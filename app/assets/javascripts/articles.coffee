@calculateFinalPrice = (element) ->
    cost = $('#article_cost_price').val()
    percentage = $('#article_percentage').val()
    cost = parseFloat(cost)
    percentage = parseFloat(percentage)
    final_element = $('#article_final_price').val((cost * percentage / 100) + cost)

@checkIfExistArticle = () ->
    if window.XMLHttpRequest
        xhttp = new XMLHttpRequest
    else
        xhttp = new ActiveXObject("Microsoft.XMLHTTP")
    e = e or window.event
    code = $('#article_code').val()
    xhttp.onreadystatechange = ->
        if xhttp.readyState == 4 && xhttp.status == 200
            x = JSON.parse(xhttp.response)
            $("#modalCheck").modal();
            return true
        else
            return false
    xhttp.open("GET", "/articles.json?q=" + code, true)
    xhttp.send()
