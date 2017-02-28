class AddTopLinkToLinks < ActiveRecord::Migration[5.0]
  def change
    add_column :links, :top_link, :boolean, :default => false
  end
end
