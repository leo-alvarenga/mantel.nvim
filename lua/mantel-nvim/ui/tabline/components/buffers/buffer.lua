local config = require("mantel-nvim.config")
local utils = require("mantel-nvim.utils")

local M = {}

--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_first boolean
--- @return mantel-nvim.Part prefix
function M.get_prefix(buf, is_first)
	local prefix = utils.evaluate_buf_aware_option(config.opts.bufs.decorators.prefix, buf)

	--- @type mantel-nvim.Part
	local part = {
		name = "prefix",
		text = prefix,
		len = utils.strlen(prefix),
		hl = "",
	}

	if part.len <= 0 then
		return {
			name = "prefix",
			text = "",
			len = 0,
			hl = "",
		}
	end

	if is_first and config.opts.style.ignore_first_buffer_prefix and config.opts.style.preset ~= "default" then
		local consts = require("mantel-nvim.constants")
		local preset = consts.styles[config.opts.style.preset]

		if preset and prefix == preset.prefix then
			return {
				name = "prefix",
				text = "",
				len = 0,
				hl = "",
			}
		end
	end

	if utils.is_current_buf(buf.bufnr) then
		part.hl = utils.evaluate_buf_aware_option(config.opts.bufs.hl.prefix, buf)
	else
		part.hl = utils.evaluate_buf_aware_option(config.opts.bufs.hl.prefix_inactive, buf)
	end

	return part
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @return mantel-nvim.Part suffix
function M.get_suffix(buf)
	local suffix = utils.evaluate_buf_aware_option(config.opts.bufs.decorators.suffix, buf)

	--- @type mantel-nvim.Part
	local part = {
		name = "suffix",
		text = suffix,
		len = utils.strlen(suffix),
		hl = "",
	}

	if part.len <= 0 then
		return {
			name = "suffix",
			text = "",
			len = 0,
			hl = "",
		}
	end

	if utils.is_current_buf(buf.bufnr) then
		part.hl = utils.evaluate_buf_aware_option(config.opts.bufs.hl.suffix, buf)
	else
		part.hl = utils.evaluate_buf_aware_option(config.opts.bufs.hl.suffix_inactive, buf)
	end

	return part
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @param position mantel-nvim.Positionable
--- @return mantel-nvim.Part[] parts, integer total_len
function M.get_decorator_parts(buf, position)
	--- @type mantel-nvim.Part[]
	local parts = {}
	local total_len = 0

	--- @type table<string, boolean>
	local rendered_decorators = {}

	local fallback_hl = config.opts.bufs.hl.inactive

	if utils.is_current_buf(buf.bufnr) then
		fallback_hl = config.opts.bufs.hl.active
	end

	for _, decorator in ipairs(config.cache.decorators[position]) do
		local text = utils.evaluate_buf_aware_option(decorator.text, buf)

		local part = {
			name = decorator.name,
			text = text,
			len = utils.strlen(text),
			hl = "",
		}

		if part.len > 0 and not rendered_decorators[decorator.name] then
			rendered_decorators[decorator.name] = true

			local hl = utils.evaluate_buf_aware_option(decorator.hl or fallback_hl, buf)

			if type(hl) == "string" then
				part.hl = hl
			end

			table.insert(parts, part)
			total_len = total_len + part.len
		end
	end

	return parts, total_len
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @return mantel-nvim.Part name
function M.get_buffer_name(buf, is_current, is_ambiguos)
	--- @type mantel-nvim.BufAwareStr
	local text = buf.name

	--- @type mantel-nvim.BufAwareStr
	local hl = config.opts.bufs.hl.inactive

	if is_current then
		hl = utils.evaluate_buf_aware_option(config.opts.bufs.hl.active, buf)
	end

	if text == "" then
		text = config.opts.bufs.overwrites.no_name
	elseif is_ambiguos then
		text = config.opts.bufs.overwrites.ambiguos
	else
		text = config.opts.bufs.overwrites.name
	end

	local name = utils.evaluate_buf_aware_option(text, buf)

	--- @type mantel-nvim.Part
	local part = {
		name = "name",
		text = name,
		len = utils.strlen(name),
		hl = utils.evaluate_buf_aware_option(hl, buf),
	}

	return part
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @return mantel-nvim.Part separator
function M.get_separator(buf)
	--- @type mantel-nvim.Part
	local part = {
		name = "separator",
		text = "",
		len = 0,
		hl = "",
	}

	part.text = utils.evaluate_buf_aware_option(config.opts.bufs.decorators.sep or "", buf)
	part.len = utils.strlen(part.text)

	if part.len <= 0 then
		return {
			name = "separator",
			text = "",
			len = 0,
			hl = "",
		}
	end

	part.hl = utils.evaluate_buf_aware_option(config.opts.bufs.hl.separator or "", buf)
	return part
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @param has_separator boolean
--- @param index integer
function M.get_buffer_parts(buf, is_current, is_ambiguos, has_separator, index)
	--- @type mantel-nvim.Part[]
	local parts = {}

	local buffer_name = M.get_buffer_name(buf, is_current, is_ambiguos)
	local prefix_decorators, prefix_decorators_len = M.get_decorator_parts(buf, "prefix")
	local name_before_decorators, name_before_decorators_len = M.get_decorator_parts(buf, "name_before")
	local name_after_decorators, name_after_decorators_len = M.get_decorator_parts(buf, "name_after")
	local suffix_decorators, suffix_decorators_len = M.get_decorator_parts(buf, "suffix")

	local inner_len = prefix_decorators_len
		+ name_before_decorators_len
		+ buffer_name.len
		+ name_after_decorators_len
		+ suffix_decorators_len

	local pl, pr = utils.get_padding_len(inner_len, config.opts.bufs.min_width, config.opts.bufs.min_padding)

	--------------------------
	--- Prefix and its decorators
	--------------------------
	table.insert(parts, M.get_prefix(buf, index == 1))
	vim.list_extend(parts, prefix_decorators)
	--------------------------

	table.insert(parts, {
		name = "padding-left",
		text = string.rep(" ", pl),
		len = pl,
		hl = buffer_name.hl,
	})

	vim.list_extend(parts, name_before_decorators)
	table.insert(parts, buffer_name)
	vim.list_extend(parts, name_after_decorators)

	table.insert(parts, {
		name = "padding-right",
		text = string.rep(" ", pr),
		len = pr,
		hl = buffer_name.hl,
	})

	--------------------------
	--- Suffix and its decorators
	--------------------------
	vim.list_extend(parts, suffix_decorators)
	table.insert(parts, M.get_suffix(buf))
	--------------------------

	if has_separator then
		table.insert(parts, M.get_separator(buf))
	end

	return parts
end

--- @param buf vim.fn.getbufinfo.ret.item
--- @param is_current boolean
--- @param is_ambiguos boolean
--- @param has_separator boolean
--- @param index integer
--- @param remaining_len integer
--- @return string part, integer remaining_len, integer total_len
function M.render_buf(buf, is_current, is_ambiguos, has_separator, index, remaining_len)
	local result = ""
	local total_len = 0
	local parts = M.get_buffer_parts(buf, is_current, is_ambiguos, has_separator, index)

	for _, part in ipairs(parts) do
		if part.len <= remaining_len then
			local text = part.text

			if part.hl and part.hl ~= "" then
				text = utils.hl(part.hl) .. text
			end

			result = result .. text
			remaining_len = remaining_len - part.len
			total_len = total_len + part.len
		else
			break
		end
	end

	return result, remaining_len, total_len
end

return M
