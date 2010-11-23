
A = [0] # 0 is length
window.A = A
flag = 2

new_record = () ->
  ret = 
    data: 0
    key: 0

window.setA = (val) ->
  A = val

window.getA = () ->
  return A

window.MakeSet = (x) ->
  x.key = 0
  A.push(x)
  A[0] = A[0] + 1 # increase length by one
  return A[0]
  
window.Find1 = (x) ->
  if A[x].key  <= 0
    return x
  else
    console.log "A[x] is A[#{x}] is #{A[x]}"
    return Find1(A[x].key)

window.Find2 = (x) ->
  console.log "x is #{x}"
  if A[x].key <= 0
    console.log "x is #{x} the key is #{A[x].key}, so heres x.."
    return x
  else
    
    A[x].key = Find2(A[x].key)
    console.log "x is #{x} the key is #{A[x].key}, loopage"
    return A[x].key

window.Link = (x, y) ->
  if -A[x].key > -A[y].key
    yRoot = A[y]
    yRoot.key = x
  else if -A[x].key == -A[y].key
    A[y].key = A[y].key - 1
    xRoot = A[x]
    xRoot.key = y


window.Union = (x,y) ->
  if flag is 1
    find = Find1
  else
    find = Find2
  xRootIndex = find x
  yRootIndex = find y
  console.log "x and y are ", x, y 
  
  Link xRootIndex, yRootIndex

  #yRoot = A[yRootIndex]
  #yRoot.key = xRootIndex
  

window.Print = () ->
  ret = ""
  for x in A[1..] #dont include the 0th element
    ret += "(#{x.key}, #{x.data})\n"
  $("#output").val(ret)


handle_input = (input) ->
  if input is "p"
    Print()
  else if input.match(/^u/)
    input = input.split(" ")
    x = input[1]
    y = input[2]    
    Union(x, y)    

handle_file = (text) ->
  text = text.split("\n")
  for data in text
    x = new_record()
    x.data = data
    MakeSet(x)

#code for reading the file
$(document).ready () ->
  $("form").submit (e)->
    e.preventDefault()
    handle_input $("input").val()
    return false

  $('#input_button').click () ->
    handle_file $("#input").val()
  
  #handle_file $("#input").val()
