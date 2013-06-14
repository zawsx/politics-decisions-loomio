class Queries::UnvotedMotions
  def self.for(user, group)
    group.motions.
    joins('LEFT OUTER JOIN votes ON votes.motion_id = motions.id').where('votes.id IS NULL AND motions.phase = ?', 'voting')
  end
end
