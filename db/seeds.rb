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

helados = Category.create!({
    name: "Helados"
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

administrador = User.create!({
      username: "administrador",
      password: "administrador",
      email: "admin@admin.com",
      admin: true,
      deactivated: false
  })

vendedor = User.create!({
      username: "vendedor",
      password: "vendedor",
      email: "ventas@ventas.com",
      admin: false,
      deactivated: false
  })
