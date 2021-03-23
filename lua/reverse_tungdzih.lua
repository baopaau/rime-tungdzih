-- reverse_lookup_tungdzih_filter: 爲候選項加上通字方案的註釋（整句）

local function reverse_lookup_filter(input, pydb)
  for cand in input:iter() do
    local comment = " "
    for _, cp in utf8.codes(cand.text) do 
      comment = comment .. string.gsub(pydb:lookup(utf8.char(cp)), " ", "/") .. " "
    end
    cand:get_genuine().comment = comment
    yield(cand)
  end
end

local function filter(input, env)
   reverse_lookup_filter(input, env.pydb)
end

local function init(env)
   env.pydb = ReverseDb("build/tungdzih.reverse.bin")
end

return { init = init, func = filter }
