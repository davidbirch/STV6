class AddIndexToBroadcastEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :broadcast_events, :formatted_local_start_date  
  end
end
