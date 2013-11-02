
local tiles = {}

function addUpdateTile(tile)
	tiles[tile] = tiles[tile] or 0
	tiles[tile] = tiles[tile] + 1
end
function removeUpdateTile(tile)
	tiles[tile] = tiles[tile] - 1
	if tiles[tile] <= 0 then
		tiles[tile] = nil
	end
end
function updateTiles(delta)
	for k,v in pairs(tiles) do
		k:update(delta)
	end
end