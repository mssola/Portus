require "integration/helper"

# TODO: each scenario has it's own class instance, with the message, where its
# resources are, how to bring up & down, etc.
feature "Smoke tests" do
  scenario "works with development docker-compose", smoke: true do
  end

  scenario "works with production non-SSL docker-compose", smoke: true do
  end

  scenario "works with production SSL docker-compose", smoke: true do
  end

  scenario "works in bare metal SSL deployment", smoke: true do
  end
end
