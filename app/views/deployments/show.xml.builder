xml.instruct!
xml.deployment do
  xml.name @deployment.name
  xml.workflow_state @deployment.workflow_state
  xml.started_at @deployment.started_at
  xml.completed_at @deployment.completed_at
  xml.in_retry @deployment.in_retry
end
