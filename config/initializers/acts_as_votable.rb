ActsAsVotable::Vote.class_eval do
  attr_accessible :votable, :voter, :vote_scope
end

