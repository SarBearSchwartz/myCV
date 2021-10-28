local highlight_author_filter = {
  Para = function(el)
    if el.t == "Span" then
    for k,_ in ipairs(el.content) do
      if el.content[k].t == "Str" and el.content[k].text == "Schwartz,"
      and el.content[k+1].t == "Space"
      and el.content[k+2].t == "Str" and el.content[k+2].text:find("^S.") then
          local _,e = el.content[k+2].text:find("^S.")
          local rest = el.content[k+2].text:sub(e+1) 
          el.content[k] = pandoc.Strong { pandoc.Str("Schwarts, S.") }
          el.content[k+1] = pandoc.Str(rest)
          table.remove(el.content, k+2) 
      end
    end
  end
  return el
  end
}

function Div (div)
  if 'refs_journals2021' or 'refs_journals2020' or 'refs_journals2019' or 'refs_journals2018' or 'refs_journals2017' or 'refs_student' or 'refs_ebook' or 'refs_proceedings' or 'refs_github' == div.identifier then
    return pandoc.walk_block(div, highlight_author_filter)
  end
  return nil
end
