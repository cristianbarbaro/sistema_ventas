# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Categories:
almacen = Category.create!({
        name: "Almacén"
    })

bebidas = Category.create!({
        name: "Bebidas"
    })

cigarrillos = Category.create!({
        name: "Cigarrillos"
    })

cocacola = Mark.create!({
        name: "Coca-Cola"
    })

marlboro = Mark.create!({
        name: "Marlboro"
    })

secco = Mark.create!({
        name: "Secco"
    })

manaos = Mark.create!({
        name: "Manaos"
    })

panaderia = Mark.create!({
        name: "Panadería"
    })

sancor = Mark.create!({
        name: "Sancor"
    })

lacteos = Category.create!({
        name: "Lacteos"
    })

#### Artículos

gaseosa = Article.create!({
        name: "Gaseosa",
        cost_price: 17.50,
        percentage: 30,
        code: 1234,
        description: "Medio litro. 500ml.",
        mark_id: secco.id,
        category_id: bebidas.id
    })
gaseosa.historics.create({
        cost_price: gaseosa.cost_price,
    })

pan = Article.create!({
        name: "Pan",
        cost_price: 22.555,
        percentage: 30,
        code: 1235,
        description: "Un kilo de mucho amor, mandale manteca.",
        mark_id: panaderia.id,
        category_id: almacen.id
    })
pan.historics.create!({
        cost_price: pan.cost_price
    })

manteca = Article.create!({
        name: "Manteca",
        cost_price: 37.50,
        percentage: 35,
        code: 1236,
        description: "Brve descripcion",
        mark_id: sancor.id,
        category_id: lacteos.id
    })
manteca.historics.create!({
        cost_price: manteca.cost_price
    })

leche = Article.create!({
        name: "Leche",
        cost_price: 7.00,
        percentage: 35,
        code: 1237,
        description: "Mmm, rico rico",
        mark_id: sancor.id,
        category_id: lacteos.id
    })
leche.historics.create!({
        cost_price: leche.cost_price
    })

#### Stocks.
gaseosa_stock = Stock.create!({
        article_id: gaseosa.id,
        minimum_amount: 10,
        current_amount: 100
    })

pan_stock = Stock.create!({
        article_id: pan.id,
        minimum_amount: 5,
        current_amount: 1000
    })

manteca_stock = Stock.create!({
        article_id: manteca.id,
        minimum_amount: 13,
        current_amount: 10
    })

leche_stock = Stock.create!({
    article_id: leche.id,
    minimum_amount: 10,
    current_amount: 10
    })

uno = Provider.create!({
        name: "Uno",
        contact: "2215529657",
        category_id: almacen.id
    })

dos = Provider.create!({
        name: "Dos",
        category_id: lacteos.id
    })

tres = Provider.create!({
        name: "Tres",
        contact: "También podemos meter una dirección.",
        category_id: almacen.id
    })

cuatro = Provider.create!({
        name: "Cuatro",
        category_id: cigarrillos.id
    })
