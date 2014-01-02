namespace :lists do

  task update_index: :environment do
    puts "> updating lists index..."
    Tire.index(List.index_name).delete
    List.create_elasticsearch_index
    Tire.index(List.index_name).import List.where(completed: true, user_id: { '$exists' => true }, deleted_at: nil).all
    puts "> Done!"
  end

end
