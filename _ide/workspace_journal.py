# 2026-01-11T14:42:44.307806200
import vitis

client = vitis.create_client()
client.set_workspace(path="C:/rustos")

platform = client.create_platform_component(name = "bsp",hw_design = "$COMPONENT_LOCATION/../hardware/artifacts/hardware_platform/rv32imacb_zicsr_zifencei_zbc-hardware_platform.xsa",os = "standalone",cpu = "mbv_microblaze_v",domain_name = "standalone_mbv_microblaze_v",compiler = "gcc")

platform = client.get_component(name="bsp")
status = platform.build()

vitis.dispose()

