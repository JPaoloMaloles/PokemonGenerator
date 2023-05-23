class CreatePokemons < ActiveRecord::Migration[7.0]
  def change
    create_table :pokemons do |t|
      t.string :national_dex_num
      t.string :name
      t.string :first_type
      t.string :second_type
      t.string :abilities
      t.decimal :hp, precision: 9, scale: 4
      t.decimal :atk, precision: 9, scale: 4
      t.decimal :defe, precision: 9, scale: 4
      t.decimal :spa, precision: 9, scale: 4
      t.decimal :spd, precision: 9, scale: 4
      t.decimal :spe, precision: 9, scale: 4
      t.string :url
      t.string :icon
      t.string :first_type_image
      t.string :second_type_image

      t.timestamps
    end
  end
end
