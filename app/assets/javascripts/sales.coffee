@disableInputsSales = () ->
    document.getElementById("searchArt").focus()
    document.getElementById("nameArt").readOnly = true
    document.getElementById("descriptionArt").readOnly = true
    document.getElementById("priceArt").readOnly = true
    document.getElementById("amountArt").readOnly = true
    document.getElementById("totalPriceArt").readOnly = true


@enableInputsSales = () ->
    document.getElementById("amountArt").focus()
    document.getElementById("nameArt").readOnly = false
    document.getElementById("descriptionArt").readOnly = false
    document.getElementById("priceArt").readOnly = false
    document.getElementById("amountArt").readOnly = false
    document.getElementById("totalPriceArt").readOnly = false


setPrecision = (number) ->
    number = parseFloat(number)
    number = number.toFixed(2)
    return parseFloat(number)


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
                document.getElementById("article_id").value = x.id
                document.getElementById("nameArt").value = x.name
                document.getElementById("descriptionArt").value = x.description
                document.getElementById("priceArt").value = setPrecision(x.final_price)
                document.getElementById("amountArt").value = 1
                document.getElementById("totalPriceArt").value = setPrecision(x.final_price)
                enableInputsSales()
            # else
            #     TODO: alert "Producto no encontrado"
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


checkAmountLines = ->
    length = document.getElementById("showArt").children.length
    if length > 1
        document.getElementById("commitBtn").disabled = false
    else
        document.getElementById("commitBtn").disabled = true


updateTotalPriceSale = (valueToAdd) ->
    partialPrice = document.getElementById("totalSalePrice").value
    document.getElementById("totalSalePrice").value = setPrecision(partialPrice) + setPrecision(valueToAdd)
    # Cada vez que actualice el total, verifico si hay líneas suficientes para habilitar o no los botones.
    # Una medida de seguridad para no enviar formularios vacíos. Se desea evitar eso lo más posible.
    checkAmountLines()


updateNumberLine = ->
    old = document.getElementById("totalLines").value
    number = parseInt(old) + 1
    document.getElementById("totalLines").value = number
    return old


@updateValues = ->
    # TODO: Revisar el tema de que haya algún artículo que fue buscadon y evitar agregar esa fila a la tabla si no es el caso.
    line = updateNumberLine()
    article_id = document.getElementById("article_id").value
    code = document.getElementById("searchArt").value
    name = document.getElementById("nameArt").value
    amount =document.getElementById("amountArt").value
    desc = document.getElementById("descriptionArt").value
    price = document.getElementById("priceArt").value
    total = document.getElementById("totalPriceArt").value
    html =
        "
        <input type='hidden' id='art_id' type='number' name='sale[sale_lines_attributes][#{line}][article_id]' value='#{article_id}'/>
        <td id='code'><input value='#{code}' style='border-width: 0px' ></td>
        <td id='amount'><input value='#{amount}' type='number' name='sale[sale_lines_attributes][#{line}][article_amount]' style='border-width: 0px' ></td>
        <td id='name'><input value='#{name}' style='border-width: 0px' ></td>
        <td id='desc'><input value='#{desc}' style='border-width: 0px' ></td>
        <td id='price'><input value='#{price}' type='number' name='sale[sale_lines_attributes][#{line}][article_final_price_unit]' style='border-width: 0px' ></td>
        <td id='total'>#{total}</td>
        <td><span id='delete' class='glyphicon glyphicon-trash' onclick='deleteLine(this, #{line});'></span></td>
        "
    node = document.createElement("tr")
    node.id = line
    node.innerHTML = html
    document.getElementById("showArt").appendChild(node)
    updateTotalPriceSale(setPrecision(total))


@deleteLine = (element, line_number) ->
    line = document.getElementById(line_number)
    # TODO: Mejorar esta línea usando id y esas cosas de javascript.
    totalArticle = setPrecision(line.children[6].innerText)
    line.remove()
    updateTotalPriceSale(totalArticle*(-1))


@addArticle = (e)->
    e = e or window.event
    if e.keyCode == 13
        amount =document.getElementById("amountArt").value
        price = document.getElementById("priceArt").value
        totalPriceArt = amount * price
        document.getElementById("totalPriceArt").value = totalPriceArt
        disableInputsSales()
        updateValues()
        cleanInputs()
