(function() {
  var A, flag, handle_file, handle_input, new_record;
  A = [0];
  window.A = A;
  flag = 2;
  new_record = function() {
    var ret;
    return (ret = {
      data: 0,
      key: 0
    });
  };
  window.setA = function(val) {
    return (A = val);
  };
  window.getA = function() {
    return A;
  };
  window.MakeSet = function(x) {
    x.key = 0;
    A.push(x);
    A[0] = A[0] + 1;
    return A[0];
  };
  window.Find1 = function(x) {
    if (A[x].key <= 0) {
      return x;
    } else {
      console.log("A[x] is A[" + (x) + "] is " + (A[x]));
      return Find1(A[x].key);
    }
  };
  window.Find2 = function(x) {
    console.log("x is " + (x));
    if (A[x].key <= 0) {
      console.log("x is " + (x) + " the key is " + (A[x].key) + ", so heres x..");
      return x;
    } else {
      A[x].key = Find2(A[x].key);
      console.log("x is " + (x) + " the key is " + (A[x].key) + ", loopage");
      return A[x].key;
    }
  };
  window.Link = function(x, y) {
    var xRoot, yRoot;
    if (-A[x].key > -A[y].key) {
      yRoot = A[y];
      return (yRoot.key = x);
    } else if (-A[x].key === -A[y].key) {
      A[y].key = A[y].key - 1;
      xRoot = A[x];
      return (xRoot.key = y);
    }
  };
  window.Union = function(x, y) {
    var find, xRootIndex, yRootIndex;
    if (flag === 1) {
      find = Find1;
    } else {
      find = Find2;
    }
    xRootIndex = find(x);
    yRootIndex = find(y);
    console.log("x and y are ", x, y);
    return Link(xRootIndex, yRootIndex);
  };
  window.Print = function() {
    var _a, _b, _c, ret, x;
    ret = "";
    _b = A.slice(1);
    for (_a = 0, _c = _b.length; _a < _c; _a++) {
      x = _b[_a];
      ret += ("(" + (x.key) + ", " + (x.data) + ")\n");
    }
    return $("#output").val(ret);
  };
  handle_input = function(input) {
    var x, y;
    if (input === "p") {
      return Print();
    } else if (input.match(/^u/)) {
      input = input.split(" ");
      x = input[1];
      y = input[2];
      return Union(x, y);
    }
  };
  handle_file = function(text) {
    var _a, _b, _c, _d, data, x;
    text = text.split("\n");
    _a = []; _c = text;
    for (_b = 0, _d = _c.length; _b < _d; _b++) {
      data = _c[_b];
      _a.push((function() {
        x = new_record();
        x.data = data;
        return MakeSet(x);
      })());
    }
    return _a;
  };
  $(document).ready(function() {
    $("form").submit(function(e) {
      e.preventDefault();
      handle_input($("input").val());
      return false;
    });
    return $('#input_button').click(function() {
      return handle_file($("#input").val());
    });
  });
})();
