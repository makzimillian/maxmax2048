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
  [0..3].map -> ([0..3].map -> 0)
  # console.log board

generateTile = (board) ->
  value = 2
  [row, column] = randomCellIndices()
  if board[row][column] is 0
    board[row][column] = value
  else
    generateTile(board)

move = (board, direction) ->
  newBoard = buildBoard()

  for i in [0..3]
    if direction in ['right', 'left']
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
    else if direction in ['down', 'up']
      column = getColumn(i, board)
      column = mergeCells(column, direction)
      column = collapseCells(column, direction)
      setColumn(column, i, newBoard)
  newBoard

getRow = (r, board) ->
  #boardArray, index
  [board[r][0], board[r][1], board[r][2], board[r][3]]

getColumn  = (c, board) ->
  [board[0][c], board[1][c], board[2][c], board[3][c]]


setRow = (row, index, board) ->
  board[index] = row

setColumn = (column, index, board) ->
  for i in [0..3]
    board[i][index] = column[i]

mergeCells = (cells, direction) ->

  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0 then break
        else if cells[a] == cells[b]
          cells[a] *= 2
          cells[b] = 0
          break
        else if cells[b] isnt 0 then break
    cells

  if direction in ['right', 'down']
    cells = merge(cells)
  else if direction in ['left', 'up']
    cells = merge(cells.reverse()).reverse()

  cells

# console.log mergeCells [4, 2, 0, 2 ], 'right'

collapseCells = (cells, direction) ->
  #remove '0'
  cells = cells.filter (x) -> x isnt 0
    #adding '0'
  while cells.length < 4
    if direction in ['right', 'down']
      cells.unshift 0
    else if direction in ['left', 'up']
      cells.push 0
  cells

# console.log collapseCells [0, 2, 4, 2], 'right'

moveisValid = (orignalBoard, newBoard) ->
  answer = true
  for row in [0..3]
    for col in [0..3]
      if orignalBoard[row][col] isnt newBoard[row][col]
        return true

  false

boardIsFull = (board) ->
  for row in board
    if 0 in row
      return false
  true

noValidMoves = (board) ->
  for direction in ['up', 'down', 'left', 'right']
    newBoard = move(board, direction)
    if moveisValid(board, newBoard)
      return false
  true

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      if board[row][col] is 0
        $(".r#{row}.c#{col} > div").html('')
      else
        $(".r#{row}.c#{col} > div").html(board[row][col])

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      for power in [1..11]
        $(".r#{row}.c#{col}").removeClass('val-' + Math.pow(2, power))
      if board[row][col] is 0
        $(".r#{row}.c#{col} > div").html('')
      else
        $(".r#{row}.c#{col} > div").hide().html(board[row][col])
        $(".r#{row}.c#{col}").addClass('val-' + board[row][col])

  # console.log "show board"

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log  "-- End--"

$ ->
  $('#gameOverFatality').hide()
  $('.board').hide()
  $('.board').fadeIn(350)
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)

  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  printArray(@board)
  showBoard(@board)
  $('.board').hide()
  $('.board').fadeIn(1900)


  @board = buildBoard()
    # console.log "i1: ", i1
    # row = []
  $('#startGame').click =>
    alert('Let the Battle Begin!')
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    showBoard(@board)

  $('#reset').click =>
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    showBoard(@board)

  $('body').keydown (e) =>

    key = e.which #(e) == event
    keys = [37..40]

    if (keys.indexOf key) > -1
    #continue the game
      # console.log "key: ", key
      e.preventDefault()
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'

  #try moving
      newBoard = move(@board, direction)
      printArray newBoard
      #check the move validity, by comparing the original and new boards
      if moveisValid(@board, newBoard)
        console.log "valid"
        @board = newBoard
        #generate board
        generateTile(@board)
        #show board
        showBoard(@board)
        #check game lost
        if isGameOver(@board)
            $(".board").fadeOut(2000)
            $("#gameOverFatality").delay(750).fadeIn(500)

        #invalid move
    else
    #do nothing

