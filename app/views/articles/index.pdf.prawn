prawn_document do |pdf|
    row = []
    table_data = []
    @articles.each_with_index do |article, index|
      if index % 3 == 0 && index != 0
        table_data.push(row)
        row = []
      end
      cell1 = pdf.make_cell(:content => article.name[0..25], :align => :center, :size => 9, :font_style => :bold)
      cell2 = pdf.make_cell("$ " + sprintf("%.2f", article.final_price), :align => :right, :text_color => '000000', :size => 28, :font_style => :bold, :padding => [0, 10, -5, 0])
      cell3 = pdf.make_cell(article.description[0..30] + "\n" + article.code.to_s + " | " + article.last_update_price.strftime("%d/%m/%Y"), :align => :right, :size => 8, :font_style => :bold)

      subtable = pdf.make_table([ [cell1], [cell2], [cell3] ],
                  :cell_style => { :borders => [] },
                  :width => 174 )
      row.push(subtable)
    end
    # Pueden quedar datos en la row, debo agregarlos antes de imprimir la tabla:
    table_data.push(row)
    pdf.table table_data, :column_widths => [300, 300, 300], :cell_style => { :border_width => 3 }
end
