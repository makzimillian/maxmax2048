randomInt = (x) ->
    Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2, 2, 2, 4]
  values[randomInt(4)]

buildBoard = ->
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #     board[row][column] = 0
  [0..3].map -> [0..3].map (->0)
  # console.log board

generateTile = (board) ->
  value = randomValue()
  console.log "randomInt: #{row} | #{column}"
  [row,column] = randomCellIndices()
  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

  console.log "generate tile"

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      $(".r#{row}.c#{col} > div").html(':)')
  console.log "show board"

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
  showBoard(newBoard)
    # console.log "i1: ", i1
    # row = []
  # generateTile()
  # generateTile()