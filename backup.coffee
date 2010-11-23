flag = 1

new_record = () ->
  ret = 
    data: 0
    key: 0

A = [0] # 0 is length

MakeSet = (x) ->
  x.key = 0
  A.push(x)
  A[0] = A[0] + 1 # increase length by one
  return A[0]
  
Find1 = (x) ->
  if A[x.key] <= 0
    return x.key
  else
    return Find1(A[x.key])

Find2 = (x) ->
  if A[x.key] < 0
    return x.key
  else
    A[x.key] = Find2(A[x.key])
    return A[x.key]
    
Union = (x,y) ->
  if flag is 1
    find = Find1
  else
    find = Find2

  xRootIndex = find x
  yRootIndex = find y
  
  yRoot = A[yRootIndex]
  yRoot.key = xRootIndex
  

Print = () ->
  ret = ""
  for x in A[1..] #dont include the 0th element
    ret += "(#{x.key}, #{x.data})\n"
  $("#output").val(ret)


handle_input = (input) ->
  alert input

$(document).ready () ->
  $("form").submit (e)->
    e.preventDefault()
    handle_input $("input").val()
    return false
