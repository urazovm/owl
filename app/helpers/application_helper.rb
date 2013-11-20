module ApplicationHelper
  def cache_key_for_lists
    max_updated_at = List.max(:updated_at).try(:utc).try(:to_s, :number)
    "lists/all-#{max_updated_at}"
  end
end
