(function(){
  var history = getHistory()
  console.log(history);
  const service_url = 'https://maps.googleapis.com/maps/api/geocode/'
  const format = 'json'//xml...
  var results = document.getElementById('results')
  var err_block = document.getElementById('error-block')

  window.onload = function(){
    var searchF = document.getElementById('search-field')
    searchF.addEventListener('keyup', onType)//pass params using ','
    searchF.parentElement.onsubmit = function(e){e.preventDefault()} //подловил submit на уровне формы (сабмит генерируется на уровне формы)
    function onType(e){
      keyCode =  e.keyCode
      if(keyCode == 13){
        console.log('sent');
        var value = searchF.value
        var url = service_url + format +'?address='+ value

        var xhr = new XMLHttpRequest()
        xhr.onreadystatechange = function(){
          if(xhr.status = 200 && xhr.readyState == 4){
            var data = JSON.parse(xhr.responseText)

            if(data.status == "OK"){
              err_block.style = 'display: none'
              var info = parseData(data)
              showData(info)
              saveHistory(info)
            }else if(data.status == "ZERO_RESULTS"){
              showEmpty()
            }
            searchF.value = ''
          }
        }
        xhr.open( "get", url)
        xhr.send()

      }
    }
    function parseData(data){
      data = data.results[0]
      var info = {
        'country' : data.address_components.pop().long_name,
        'city' : data.address_components[1].long_name,
        'lat' : data.geometry.location.lat,
        'lng' : data.geometry.location.lng
      }
      return info
    }
    function showData(info){
      var res_item = document.createElement('div')
      res_item.className = 'res-block'
      for(var key in info){
        var span = document.createElement('span')
        span.innerHTML = `<b>${key}</b>:${info[key]}<br>`
        res_item.appendChild(span)
      }
      res_item.className += ' animated bounceIn'
      results.insertBefore(res_item, results.childNodes[0])
    }
    function showEmpty(){
      err_block.style = 'display: inline-block'
      err_block.className += ' animated fadeInUp'
    }
  };

  function getHistory(){
    let res = JSON.parse( sessionStorage.getItem('history') )
    return res?res:[]
  }
  function saveHistory(info){
    history.unshift(info)
    sessionStorage.setItem( 'history', JSON.stringify(history) )
  }
})()

// отобразить результаты
// отобразить сообщение no reslts found on *value* если нету результатов
// очищать поле после принятия ответа
// preloader
