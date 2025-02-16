function Doc(doc)
	local notes = {}
	local function is_footnote(el)
		return el.t == "Note"
	end
	doc.blocks:walk {
		Note = function(note)
			table.insert(notes, note)
			return {}
		end
	}
	table.insert(doc.blocks, pandoc.Header(1, "Notes"))
	for _, note in ipairs(notes) do
		table.insert(doc.blocks, note)
	end
	return doc
end
