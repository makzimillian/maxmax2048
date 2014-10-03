randomInt = (x) ->
    Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2, 4, 2, 4]
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
  [row, column] = randomCellIndices()
  console.log "randomInt: #{row} | #{column}"

  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

  console.log "generate tile"

move = (board, direction) ->
  newBoard = buildBoard()

  for i in [0..3]
    if direction is 'right'
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)


  newBoard

getRow = (r, board) ->
  #boardArray, index
  row = [board[r][0], board[r][1], board[r][2], board[r][3]]

setRow = (row, index, board) ->
  board[index] = row


mergeCells = (row, direction) ->
  if direction is 'right'
    for a in [3...0]
      for b in [a-1..0]
        if row[a] is 0 then break
        else if row[a] == row[b]
          row[a] *= 2
          row[b] = 0
          break
        else if row[b] isnt 0 then break
  row

# console.log mergeCells [4, 2, 0, 2 ], 'right'

collapseCells = (row, direction) ->
  #remove '0'
  row = row.filter (x) -> x isnt 0
    #adding '0'
  if direction is 'right'
    while row.length < 4
      row.unshift 0

  row

console.log collapseCells [0, 2, 4, 2], 'right'

moveisValid = (orignalBoard, newBoard) ->
  answer = true
  for row in [0..3]
    for col in [0..3]
      if orignalBoard[row][col] isnt newBoard[row][col]
        return true

  false


showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      $(".r#{row}.c#{col} > div").html(board[row][col])
  # console.log "show board"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log  "-- End--"

$ ->
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  printArray(@board)
  showBoard(@board)
    # console.log "i1: ", i1
    # row = []
  $('body').keydown (e) =>
    e.preventDefault()

    key = e.which #(e) == event
    keys = [37..40]

    if (keys.indexOf key) > -1
    #continue the game
      console.log "key: ", key
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'
      # console.log "direction: ", direction

  #try moving
      newBoard = move(@board, direction)
      printArray newBoard
      #check the move validity, by comparing the original and new boards
      if  moveisValid(@board, newBoard)
        console.log "valid"
        @board = newBoard
        #generate board
        generateTile(@board)
        #show board
        showBoard(@board)
      else
        console.log "invalid"

    else
    #do nothing

