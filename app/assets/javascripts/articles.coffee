@calculateFinalPrice = (element) ->
    cost = document.getElementById('article_cost_price').value
    percentage = document.getElementById('article_percentage').value
    cost = parseFloat(cost)
    percentage = parseFloat(percentage)
    console.log cost
    console.log percentage
    final_element = document.getElementById('article_final_price')
    final_element.value = (cost * percentage / 100) + cost
    # final_element.select()
