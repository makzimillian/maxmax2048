// Generated by CoffeeScript 1.8.0
(function() {
  var buildBoard, generateTile, printArray, randomCellIndices, randomInt, randomValue, showBoard;

  randomInt = function(x) {
    return Math.floor(Math.random() * x);
  };

  randomCellIndices = function() {
    return [randomInt(4), randomInt(4)];
  };

  randomValue = function() {
    var values;
    values = [2, 2, 2, 4];
    return values[randomInt(4)];
  };

  buildBoard = function() {
    return [0, 1, 2, 3].map(function() {
      return [0, 1, 2, 3].map((function() {
        return 0;
      }));
    });
  };

  generateTile = function(board) {
    var column, row, value, _ref;
    value = randomValue();
    console.log("randomInt: " + row + " | " + column);
    _ref = randomCellIndices(), row = _ref[0], column = _ref[1];
    if (board[row][column] === 0) {
      board[row][column] = value;
    } else {
      generateTile(board);
    }
    return console.log("generate tile");
  };

  showBoard = function(board) {
    var col, row, _i, _j;
    for (row = _i = 0; _i <= 3; row = ++_i) {
      for (col = _j = 0; _j <= 3; col = ++_j) {
        $(".r" + row + ".c" + col + " > div").html(':)');
      }
    }
    return console.log("show board");
  };

  printArray = function(array) {
    var row, _i, _len;
    console.log("-- Start --");
    for (_i = 0, _len = array.length; _i < _len; _i++) {
      row = array[_i];
      console.log(row);
    }
    return console.log("-- End--");
  };

  $(function() {
    var newBoard;
    newBoard = buildBoard();
    generateTile(newBoard);
    generateTile(newBoard);
    printArray(newBoard);
    return showBoard(newBoard);
  });

}).call(this);

//# sourceMappingURL=main.js.map
