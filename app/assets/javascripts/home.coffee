@disableInputsSales = () ->
    document.getElementById("nameArt").readOnly = true
    document.getElementById("descriptionArt").readOnly = true
    document.getElementById("priceArt").readOnly = true
    document.getElementById("amountArt").readOnly = true
    document.getElementById("totalPriceArt").readOnly = true


@enableInputsSales = () ->
    document.getElementById("nameArt").readOnly = false
    document.getElementById("descriptionArt").readOnly = false
    document.getElementById("priceArt").readOnly = false
    document.getElementById("amountArt").readOnly = false
    document.getElementById("totalPriceArt").readOnly = false


@saveLines = () ->
    lines_array = localStorage.getItem("lines") || "[]"
    localStorage.removeItem("lines")
    lines_array = JSON.parse(lines_array)
    to_ret = []
    for line, i in lines_array
        to_ret.push(JSON.parse(localStorage.getItem(line)))
        localStorage.removeItem(line)
    # return to_ret
    $.ajax
    type: 'post'
    url: '/articles.json'
    dataType: 'json'
    data: to_ret
    success: (result) ->
        console.log JSON.stringify(to_ret)
        # return


@searchArticle = (e) ->
    if window.XMLHttpRequest
        # code for modern browsers
        xhttp = new XMLHttpRequest
    else
        # code for IE6, IE5
        xhttp = new ActiveXObject("Microsoft.XMLHTTP")

    e = e or window.event
    if e.keyCode == 13
        article_code = document.getElementById('searchArt').value
        element = document.getElementById('showForm')
        xhttp.onreadystatechange = ->
            if xhttp.readyState == 4 && xhttp.status == 200
                x = JSON.parse(xhttp.response)
                final_price_unit = parseFloat(x.cost_price) + parseFloat(x.cost_price * x.percentage / 100)
                document.getElementById("article_id").value = x.id
                document.getElementById("nameArt").value = x.name
                document.getElementById("descriptionArt").value = x.description
                document.getElementById("priceArt").value = final_price_unit
                document.getElementById("amountArt").value = 1
                document.getElementById("totalPriceArt").value = final_price_unit
                enableInputsSales()
                document.getElementById("amountArt").focus()
            # else
            #     alert "Producto no encontrado"
                #Aquí intentar habilitar el enter para los otros campos, sino no hacerlo
    xhttp.open("GET", "/articles.json?q=" + article_code, true)
    xhttp.send()


cleanInputs = ->
    document.getElementById("article_id").value = ""
    document.getElementById("nameArt").value = ""
    document.getElementById("descriptionArt").value = ""
    document.getElementById("priceArt").value = ""
    document.getElementById("amountArt").value = ""
    document.getElementById("totalPriceArt").value = ""
    document.getElementById("searchArt").value = ""
    document.getElementById("searchArt").focus()


updateTotalPriceSale = (valueToAdd) ->
    val = document.getElementById("totalSalePrice").value
    console.log(valueToAdd)
    partialPrice = parseFloat(val)
    document.getElementById("totalSalePrice").value = partialPrice + parseFloat(valueToAdd)


updateNumberLine = ->
    number = document.getElementById("totalLines").value
    number = parseInt(number) + 1
    document.getElementById("totalLines").value = number
    return number


# saveLineStorage = (line) ->
#     #TODO


@updateValues = ->
    # Revisar el tema de que haya algún artículo que fue buscadon y evitar agregar esa fila a la tabla si no es el caso.
    line = updateNumberLine()
    article_id = document.getElementById("article_id").value
    code = document.getElementById("searchArt").value
    name = document.getElementById("nameArt").value
    desc = document.getElementById("descriptionArt").value
    price = document.getElementById("priceArt").value
    amount =document.getElementById("amountArt").value
    total = document.getElementById("totalPriceArt").value
    html =
        "
        <input type='hidden' id='line_number' value='#{line}'/>
        <input type='hidden' id='art_id' value='#{article_id}'/>
        <td id='code'>#{code}</td>
        <td id='amount'>#{amount}</td>
        <td id='name'>#{name}</td>
        <td id='desc'>#{desc}</td>
        <td id='price'>#{price}</td>
        <td id='total'>#{total}</td>
        <td><span class='glyphicon glyphicon-trash'></span></td>
        "
    obj = {
        'article_id': article_id,
        'article_amount': amount,
        'article_final_price_unit': price
    }
    # Se almanena la línea y en un arreglo se lleva el control de los nros de líneas almancenados para su posterior iteración.
    lines = localStorage.getItem("lines") || "[]"
    lines = JSON.parse(lines)
    lines.push(line)
    localStorage.setItem("lines", JSON.stringify(lines))
    localStorage.setItem(line, JSON.stringify(obj))
    # Fin de ese procesamiento.
    node = document.createElement("tr")
    node.id = line
    node.innerHTML = html
    document.getElementById("showArt").appendChild(node)
    updateTotalPriceSale(total)
    # saveLineStorage(line)
    cleanInputs()


@addArticle = (e)->
    e = e or window.event
    if e.keyCode == 13
        amount =document.getElementById("amountArt").value
        price = document.getElementById("priceArt").value
        totalPriceArt = amount * price
        document.getElementById("totalPriceArt").value = totalPriceArt
        disableInputsSales()
        updateValues()
