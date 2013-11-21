class AddAntibullying < ActiveRecord::Migration
  def change
    ab = Skill.new(:name => "Anti-Bullying", :offset => 19 )
    ab.save!
  end
end
