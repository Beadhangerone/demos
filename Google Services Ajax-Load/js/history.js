(function(){
  var history = getHistory()

  var history_b = document.getElementById('history')
  showHistory()
// =================== //
  function getHistory(){
    let res = JSON.parse( sessionStorage.getItem('history') )
    return res?res:[]
  }
  function showHistory(){
    for(var i in history){
      var item = history[i]
      var res_item = document.createElement('div')
      res_item.className = 'res-block'
      for (var key in item){
        var span = document.createElement('span')
        span.innerHTML = `<b>${key}</b>:${item[key]}<br>`
        res_item.appendChild(span)
      }
      history_b.appendChild(res_item)
    }
  }

})()
