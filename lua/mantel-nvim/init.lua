local consts = require("mantel-nvim.constants")
local icons = require("mantel-nvim.icons")

---------------------------------------------
--- Modules
---------------------------------------------

local Mantel = {}
local H = {}

H.config = consts.default_config

H.cache = {
	labels = {},
}
H.state = {
	buf_positions = {},
	next_position = 1,
}

---------------------------------------------
--- Basics
---------------------------------------------

--- @param hl string?
--- @return string
function H.fmt_hl(hl)
	if not hl or hl == "" then
		return ""
	end

	return "%#" .. hl .. "#"
end

--- Pads a number by 2% to account for potential outliers in calculations
--- @param val integer
--- @return integer
function H.pad_num(val)
	return math.ceil(val * 1.02)
end

--- @param label string
--- @param bufnr integer
function H.wrap_with_click(label, bufnr)
	if not bufnr or type(bufnr) ~= "number" then
		return label
	end

	return "%" .. bufnr .. "@v:lua.Mantel_on_click@" .. label .. "%T"
end

function H.set_config(opts)
	opts = opts or {}
	H.config = vim.tbl_deep_extend("force", {}, consts.default_config, opts)
end

--- @param bypass_sorting boolean?
function H.get_bufs(bypass_sorting)
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })

	if H.state.mode == "classic" or bypass_sorting == true then
		return bufs
	end

	for _, buf in ipairs(bufs) do
		H.add_buf(buf.bufnr)
	end

	table.sort(bufs, function(a, b)
		local pos_a = H.state.buf_positions[a.bufnr] or math.huge
		local pos_b = H.state.buf_positions[b.bufnr] or math.huge

		return pos_a < pos_b
	end)

	return bufs
end

function H.call_update()
	vim.cmd("redrawtabline")
end

function H.is_buffer_valid(bufnr)
	return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end

function H.strlen(str)
	if type(str) ~= "string" then
		return 0
	end

	return vim.fn.strdisplaywidth(str)
end

---------------------------------------------
--- TabPage Rendering
---------------------------------------------

function H.get_tabpages()
	return vim.fn.gettabinfo()
end

function H.render_tabpages()
	local tabpages = H.get_tabpages()

	if #tabpages < 2 and H.config.tabpages ~= true then
		return "", ""
	end

	local curr = vim.api.nvim_tabpage_get_number(vim.api.nvim_get_current_tabpage())
	local edges = H.get_edges()

	local res = H.fmt_hl(H.config.hl.edge) .. edges.left
	res = res .. H.fmt_hl(H.config.hl.tab_active) .. " " .. curr
	res = res .. H.fmt_hl(H.config.hl.tab_inactive) .. "/" .. #tabpages .. " "

	local raw = edges.left .. curr .. "/" .. #tabpages

	if not H.config.ignore_first_and_last_edges then
		res = res .. H.fmt_hl(H.config.hl.edge) .. edges.right
		raw = raw .. edges.right
	end

	return res .. H.fmt_hl(H.config.hl.fill), raw
end

---------------------------------------------
--- Buffer Management
---------------------------------------------

--- @param bufnr integer
function H.add_buf(bufnr)
	local existing_position = H.state.buf_positions[bufnr]

	if not existing_position or type(existing_position) ~= "number" then
		H.state.buf_positions[bufnr] = H.state.next_position
		H.state.next_position = H.state.next_position + 1

		return H.state.buf_positions[bufnr]
	end

	return existing_position
end

--- @param bufnr integer
function H.remove_buf(bufnr)
	--- @type table<integer, integer>
	local positions = {}

	local i = 1
	for _, buf in ipairs(H.state.buf_positions) do
		if buf ~= bufnr then
			positions[buf] = i
			i = i + 1
		end
	end

	H.state.buf_positions = positions
	H.state.next_position = i
end

--- @param delta integer How much to move (positive for right, negative for left)
--- @param call_update boolean? Whether to trigger an update after
function H.go_to_buf_delta(delta, call_update)
	local bufs = H.get_bufs()

	if #bufs <= 1 then
		return
	end

	local current_bufnr = vim.api.nvim_get_current_buf()

	--- @type integer|nil
	local target_index = nil

	for i, buf in ipairs(bufs) do
		if buf.bufnr == current_bufnr then
			target_index = i + delta
			break
		end
	end

	if target_index then
		if target_index < 1 then
			target_index = #bufs
		elseif target_index > #bufs then
			target_index = 1
		end

		if not bufs[target_index] then
			return
		end

		vim.api.nvim_set_current_buf(bufs[target_index].bufnr)
	end

	if call_update == true then
		H.call_update()
	end
end

--- @param delta integer How much to move
--- @param call_update boolean? Whether to trigger an update after moving
function H.move_current_buf(delta, call_update)
	local current_bufnr = vim.api.nvim_get_current_buf()
	local current_position = H.state.buf_positions[current_bufnr]

	if delta == 0 or math.abs(delta) > 1 then
		return
	end

	if not current_position then
		current_position = H.add_buf(current_bufnr)
	end

	local new_position = current_position + delta

	if new_position < 1 or new_position > H.state.next_position then
		return
	end

	for bufnr, pos in pairs(H.state.buf_positions) do
		if pos == new_position then
			H.state.buf_positions[bufnr] = current_position
			H.state.buf_positions[current_bufnr] = new_position

			if call_update == true then
				H.call_update()
			end

			return
		end
	end
end

function _G.Mantel_on_click(bufnr)
	if type(bufnr) ~= "number" then
		return
	end

	if not H.is_buffer_valid(bufnr) then
		return
	end

	vim.api.nvim_set_current_buf(bufnr)
end

---------------------------------------------
--- Buffer Line Rendering
---------------------------------------------

function H.get_edges()
	return consts.edges_by_preset[H.config.preset] or consts.edges_by_preset["none"]
end

function H.get_buffer_name(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr) or ""

	if name == "" then
		name = "[No Name]"
	else
		name = vim.fn.fnamemodify(name, ":t")
	end

	return name
end

function H.get_buffer_padding(label)
	local pl = H.config.buffer_padding
	local pr = pl

	local edges = H.get_edges()
	local edges_len = H.strlen(edges.left) + H.strlen(edges.right)

	local raw_len = H.strlen(label) + edges_len
	local total_len = raw_len + pl + pr

	if total_len < H.config.min_buffer_len then
		pl = math.floor((H.config.min_buffer_len - H.strlen(label)) / 2)
		pr = math.max(0, H.config.min_buffer_len - raw_len - pl)
	end

	return string.rep(" ", pl), string.rep(" ", pr)
end

--- @param bufnr integer
function H.get_icon_for_buffer(bufnr)
	if not H.config.enable_icons then
		return ""
	end

	local icon = icons.get_icon(bufnr)

	if H.strlen(icon) > 0 then
		return icon .. "  "
	end

	return ""
end

function H.make_buffer_label(bufnr)
	local name = H.get_buffer_name(bufnr)

	local icon = H.get_icon_for_buffer(bufnr)
	if H.strlen(icon) > 0 then
		name = icon .. name
	end

	if vim.bo[bufnr].modified then
		name = name .. H.config.icons.modified
	end

	local pl, pr = H.get_buffer_padding(name)
	return pl .. name .. pr
end

function H.get_buffer_line_items()
	local buffers = H.get_bufs()
	local items = {}
	local indexes = {}

	for i, buf in ipairs(buffers) do
		if H.is_buffer_valid(buf.bufnr) then
			local label = H.make_buffer_label(buf.bufnr)

			table.insert(items, {
				bufnr = buf.bufnr,
				label = label,
				name = vim.api.nvim_buf_get_name(buf.bufnr) or "",
				modified = vim.bo[buf.bufnr].modified,
			})

			indexes[buf.bufnr] = i
		end
	end

	return items, indexes
end

function H.make_item_parts(item, i)
	local parts = {}

	if not item or type(item) ~= "table" then
		return parts
	end

	local hl = H.config.hl.inactive

	local edges = H.get_edges()
	local edges_hl = H.config.hl.edge_inactive
	if item.bufnr == vim.api.nvim_get_current_buf() then
		hl = H.config.hl.active
		edges_hl = H.config.hl.edge
	end

	if i > 1 or not H.config.ignore_first_and_last_edges then
		table.insert(parts, { content = edges.left, hl = edges_hl })
	end

	table.insert(parts, { content = item.label, hl = hl })
	table.insert(parts, { content = edges.right, hl = edges_hl })

	return parts
end

--- @param item table
--- @param i integer
--- @param max_width integer
--- @param invert boolean?
function H.make_item_string(item, i, max_width, invert)
	local res = ""
	local len = 0

	if max_width <= 0 or not item or type(item) ~= "table" then
		return res, len
	end
	for _, part in ipairs(H.make_item_parts(item, i)) do
		if len >= max_width then
			break
		end

		local has_overflow = H.strlen(part.content) > max_width

		if H.strlen(part.content) > 0 then
			local content = part.content

			if has_overflow then
				if invert then
					local start = H.strlen(content) - max_width
					content = vim.fn.strcharpart(content, start + 2)
				else
					content = vim.fn.strcharpart(content, 0, max_width)
				end
			end

			local content_len = H.strlen(content)
			res = res .. H.fmt_hl(part.hl) .. content

			len = len + content_len
		end
	end

	res = H.wrap_with_click(res, item.bufnr)

	-- Adding a small buffer to account for potential truncation issues and the edges
	return res, H.pad_num(len)
end

--- @param max_width integer
function H.render_buffer_line(max_width)
	local line = ""

	local items, indexes = H.get_buffer_line_items()
	local curr_buf_index = indexes[vim.api.nvim_get_current_buf()] or 1
	local curr_buf = items[curr_buf_index]
	local curr_str, curr_len = H.make_item_string(curr_buf, curr_buf_index, max_width)

	local remaining_width = math.max(0, max_width - curr_len)

	line = line .. curr_str

	--- @return string
	local function get_left()
		local left_line = ""

		for i = curr_buf_index - 1, 1, -1 do
			if remaining_width <= 0 then
				break
			end

			local item = items[i]
			local str, len = H.make_item_string(item, i, remaining_width, true)

			left_line = str .. left_line
			remaining_width = remaining_width - len
		end

		return left_line
	end

	--- @return string
	local function get_right()
		local right_line = ""

		for i = curr_buf_index + 1, #items do
			if remaining_width <= 0 then
				break
			end

			local item = items[i]
			local str, len = H.make_item_string(item, i, remaining_width)

			right_line = right_line .. str
			remaining_width = remaining_width - len
		end

		return right_line
	end

	local left_line = get_left()
	local right_line = ""

	if remaining_width > 0 then
		right_line = get_right()
	end

	line = left_line .. line .. right_line

	return line .. H.fmt_hl(H.config.hl.fill)
end

---------------------------------------------
--- Tabline

---------------------------------------------
function H.render_tabline()
	local tabline_width = vim.o.columns

	local tabpages_str, raw_tabpages_str = H.render_tabpages()
	local available_width = tabline_width - H.pad_num(H.strlen(raw_tabpages_str))

	local buffer_line_str = H.render_buffer_line(available_width)

	return buffer_line_str .. "%=" .. tabpages_str
end

---------------------------------------------
--- Commands & Autocmds
---------------------------------------------

function H.setup_cmds()
	vim.api.nvim_create_user_command("MantelBufNext", function()
		H.go_to_buf_delta(1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelBufPrev", function()
		H.go_to_buf_delta(-1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelMoveBufLeft", function()
		H.move_current_buf(-1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelMoveBufRight", function()
		H.move_current_buf(1, true)
	end, {})

	vim.api.nvim_create_user_command("MantelRedraw", function()
		H.call_update()
	end, {})
end

function H.setup_autocmds()
	vim.api.nvim_create_autocmd("BufAdd", {
		callback = function(args)
			H.add_buf(args.buf)
		end,
	})

	vim.api.nvim_create_autocmd("BufDelete", {
		callback = function(args)
			H.remove_buf(args.buf)
		end,
	})
end

---------------------------------------------
--- Meta
---------------------------------------------

Mantel.patch = "0"
Mantel.minor = "30"
Mantel.major = "0"

Mantel.version = Mantel.major .. "." .. Mantel.minor .. "." .. Mantel.patch

function H.setup_tabline()
	vim.o.showtabline = 2
	vim.o.tabline = "%!v:lua.require'mantel-nvim'.render()"
end

function Mantel.render()
	return H.render_tabline()
end

--- @param opts table
function Mantel.setup(opts)
	H.set_config(opts)
	H.setup_tabline()

	H.setup_cmds()
	H.setup_autocmds()

	local highlights = require("mantel-nvim.highlights")
	highlights.load_colors()
end

return Mantel
