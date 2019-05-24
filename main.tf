# Configure the provider
provider "azurerm" {
    version = "=1.28.0"
}

# Create a new resource group
resource "azurerm_resource_group" "rg" {
    name     = "tfWebAppRG"
    location = "uksouth"
	tags {
		environment = "TF WebApp"
	}
}

resource "azurerm_app_service_plan" "sp" {
    name = "my-service-plan"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    location = "${azurerm_resource_group.rg.location}"
    kind = "Windows"

    sku {
        size = "S1"
        tier = "Standard"
    }
}

resource "azurerm_app_service" "wa" {
    name = "my-website-app"
    location = "${azurerm_resource_group.rg.location}"
    app_service_plan_id = "${azurerm_app_service_plan.sp.id}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    site_config {
        default_documents = ["index.html"]
    }
}

resource "azurerm_app_service" "wa2" {
    name = "my-website-app2"
    location = "${azurerm_resource_group.rg.location}"
    app_service_plan_id = "${azurerm_app_service_plan.sp.id}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

    site_config {
        default_documents = ["index.html"]
    }
}

