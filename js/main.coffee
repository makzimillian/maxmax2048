randomInt = (x) ->
    Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

buildBoard = ->
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #     board[row][column] = 0
  [0..3].map -> [0..3].map (->0)
  # console.log board

generateTile = (board) ->
  value = 2
  console.log "randomInt: #{randomCellIndices()}"
  [row,column] = randomCellIndices()
  board[row][column] = value
  console.log "generate tile"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log  "-- End--"

$ ->
  newBoard = buildBoard()
  generateTile(newBoard)
  generateTile(newBoard)
  printArray(newBoard)
    # console.log "i1: ", i1
    # row = []
  # generateTile()
  # generateTile()