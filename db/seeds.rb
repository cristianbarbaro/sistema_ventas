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

lacteos = Category.create!({
        name: "Lacteos"
    })

# Marks:
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

### Proveedores
uno = Provider.create!({
        name: "Uno",
        contact: "2215529657",
    })

dos = Provider.create!({
        name: "Dos",
    })

tres = Provider.create!({
        name: "Tres",
        contact: "También podemos meter una dirección.",
    })

cuatro = Provider.create!({
        name: "Cuatro",
    })

#### Artículos
gaseosa = Article.create!({
        name: "Gaseosa",
        cost_price: 17.50,
        percentage: 30,
        final_price: 25.00,
        code: 1234,
        description: "Medio litro. 500ml.",
        mark_id: secco.id,
        category_id: bebidas.id,
        stock_attributes: {
                minimum_amount: 10,
                current_amount: 15,
            },
    })
gaseosa.historics.create({
        cost_price: gaseosa.cost_price,
    })
gaseosa.article_providers.create!({
        provider_id: uno.id
    })

pan = Article.create!({
        name: "Pan",
        cost_price: 22.555,
        percentage: 30,
        final_price: 29.50,
        code: 1235,
        description: "Un kilo de mucho amor, mandale manteca.",
        mark_id: panaderia.id,
        category_id: almacen.id,
        stock_attributes: {
                minimum_amount: 10,
                current_amount: 15,
            },
    })
pan.historics.create!({
        cost_price: pan.cost_price
    })
pan.article_providers.create!({
        provider_id: dos.id
    })

manteca = Article.create!({
        name: "Manteca",
        cost_price: 37.50,
        percentage: 35,
        final_price: 43.75,
        code: 1236,
        description: "Brve descripcion",
        mark_id: sancor.id,
        category_id: lacteos.id,
        stock_attributes: {
                minimum_amount: 10,
                current_amount: 15,
            },
    })
manteca.historics.create!({
        cost_price: manteca.cost_price
    })
manteca.article_providers.create!({
        provider_id: tres.id
    })

leche = Article.create!({
        name: "Leche",
        cost_price: 7.00,
        percentage: 35,
        final_price: 10.00,
        code: 1237,
        description: "Mmm, rico rico",
        mark_id: sancor.id,
        category_id: lacteos.id,
        stock_attributes: {
                minimum_amount: 10,
                current_amount: 15,
            },
    })
leche.historics.create!({
        cost_price: leche.cost_price
    })
leche.article_providers.create!({
        provider_id: cuatro.id
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

# Faker data.
def load_categories
    25.times do
        c = Category.create(
            name: Faker::Commerce.department,
        )
    end
end

def load_providers
    100.times do
        c = Provider.create({
                name: Faker::Name.name,
                contact: Faker::PhoneNumber.phone_number,
            })
    end
end

def load_marks
    50.times do
        c = Mark.create!({
                name: Faker::Commerce.product_name,
            })
    end
end

def load_articles
    200.times do
        cost_price = Faker::Commerce.price
        percentage = Faker::Number.between(0, 100)
        final_price = cost_price * percentage / 100 + cost_price
        c = Article.create!({
                name: Faker::Company.name,
                percentage: percentage,
                cost_price: cost_price,
                final_price: final_price,
                code: Faker::Number.number(6),
                description: Faker::Lorem.sentence(3, true),
                mark_id: Faker::Number.between(1, 50),
                category_id: Faker::Number.between(1, 25),
                stock_attributes: {
                    minimum_amount: Faker::Number.between(1, 50),
                    current_amount: Faker::Number.between(1, 50),
                },
            })
            c.historics.create!({
                cost_price: cost_price
            })
            c.article_providers.create!({
                provider_id: Faker::Number.between(1, 100)
            })
    end
end

administrador = User.create!({
      username: "administrador",
      password: "administrador",
      email: "admin@admin.com",
      admin: true
  })

vendedor = User.create!({
      username: "vendedor",
      password: "vendedor",
      email: "ventas@ventas.com",
      admin: false
  })

load_providers
load_marks
load_categories
load_articles
