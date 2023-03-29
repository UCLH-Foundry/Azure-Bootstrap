#  Copyright (c) University College London Hospitals NHS Foundation Trust
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

resource "azurerm_resource_group" "bootstrap" {
  name     = "rg-bootstrap-${var.suffix}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_log_analytics_workspace" "bootstrap" {
  name                = "log-bootstrap-${var.suffix}"
  resource_group_name = azurerm_resource_group.bootstrap.name
  location            = azurerm_resource_group.bootstrap.location
  sku                 = "PerGB2018"
  retention_in_days   = 90
  tags                = var.tags
}

module "build-agent" {
  name                = each.value
  resource_group_name = azurerm_resource_group.bootstrap.name
  location            = azurerm_resource_group.bootstrap.location
  shared_subnet_id    = azurerm_subnet.shared.id
  github_runner_token = var.github_runner_token
  github_organization = var.github_organization
  github_runner_name  = var.github_runner_name
  gh_runner_version   = var.gh_runner_version
}
