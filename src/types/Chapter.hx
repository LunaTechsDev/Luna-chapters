package types;

typedef Chapter = {
 name: String,
 description: String,
 summary: String,
 thumbnail: String,
 lockState: Bool,
 startMapId: Int,
 playerX: Int,
 playerY: Int,
 requiredVariables: Array<Int>,
 requiredSwitches: Array<Int>
}
