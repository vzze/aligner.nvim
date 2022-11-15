local aligner = {}

aligner.align = function (arg1, arg2, token)
    local lines = vim.api.nvim_buf_get_lines(0, arg1 - 1, arg2, true);

    local ind = {}

    for key, value in ipairs(lines) do
        local s = 0
        local e = 0
        ind[key] = {}
        s, e = string.find(value, token, s)
        while s ~= nil do
            table.insert(ind[key], s)
            s = e + 1
            s, e = string.find(value, token, s)
        end
    end

    local max = 0

    for _, value in ipairs(ind) do
        if max < #value then
            max = #value
        end
    end

    for _, value in ipairs(ind) do
        while #value ~= max do
            table.insert(value, -1)
        end
    end

    local str = ""

    for j = 1, #ind[1], 1 do
        local len_m = 0
        for _, value in ipairs(ind) do
            if len_m < value[j] then
                len_m = value[j]
            end
        end

        for key, value in ipairs(lines) do
            if ind[key][j] ~= -1 then
                for _ = 1, len_m - ind[key][j], 1 do
                    str = str .. " "
                end
                for x = j + 1, #ind[key], 1 do
                    if ind[key][x] ~= -1 then
                        ind[key][x] = ind[key][x] + len_m - ind[key][j]
                    end
                end
                lines[key] = string.sub(value, 0, ind[key][j] - 1) .. str .. string.sub(value, ind[key][j])
                str = ""
            end
        end
    end

    vim.api.nvim_buf_set_lines(0, arg1 - 1, arg2, true, lines)
end

return aligner
