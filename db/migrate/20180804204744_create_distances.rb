class CreateDistances < ActiveRecord::Migration[5.2]
  def change
    enable_extension 'uuid-ossp'
    enable_extension 'pgcrypto'

    create_table :distances, id: :uuid do |t|
      t.string :point_a
      t.string :point_b
      t.integer :distance

      t.timestamps
    end
  end
end
