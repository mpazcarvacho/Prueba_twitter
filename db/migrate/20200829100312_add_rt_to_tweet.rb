class AddRtToTweet < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :rt_id, :integer
  end
end
