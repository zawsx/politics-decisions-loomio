class RemoveCampaignSignupsAndCampaigns < ActiveRecord::Migration
  def up
    drop_table :campaign_signups
    drop_table :campaigns
  end

  def down
  end
end
