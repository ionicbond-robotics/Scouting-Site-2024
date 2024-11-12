'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "966c33c9ef2642d75a03be5a8db89c76",
"index.html": "56f36c2ead1d9fdbb955d329c6bc0348",
"/": "56f36c2ead1d9fdbb955d329c6bc0348",
"version.json": "7af4e8cfb7cd22b96b1a6a0dac3902ad",
"icons/team_logo.png": "04e70cf7cdef71ee3138134781719395",
"favicon.png": "04e70cf7cdef71ee3138134781719395",
"assets/fonts/MaterialIcons-Regular.otf": "69052a5566c2cba82b461e2c98ea2ef2",
"assets/AssetManifest.json": "440f83363d97b9f199fb65df7c450e3e",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/images/team_logo.png": "04e70cf7cdef71ee3138134781719395",
"assets/AssetManifest.bin": "135e650153f67534393a8032c31e4a53",
"assets/AssetManifest.bin.json": "c93cadc725b3ebce57d6eda51d40b966",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/matches.json": "3ac799829cc0ebdb82215945a8ce0bf3",
"assets/NOTICES": "b1295e3340b443f89b3c0b0980ea75b1",
"main.dart.js": "67a94d347ec894303829ff11c8835840",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
".git/HEAD": "978cf7ce582a3595b9d4daf7cc63115a",
".git/index": "ba99f8c7b06d48858e99193a4ab86bd6",
".git/COMMIT_EDITMSG": "655d242e09a0059e6c1fb1b459626ad7",
".git/config": "6f1a0b00ee4d84b7c8c73071bcfdb47d",
".git/hooks/post-update.sample": "2b7ea5cee3c49ff53d41e00785eb974c",
".git/hooks/prepare-commit-msg.sample": "2b5c047bdb474555e1787db32b2d2fc5",
".git/hooks/fsmonitor-watchman.sample": "a0b2633a2c8e97501610bd3f73da66fc",
".git/hooks/pre-merge-commit.sample": "39cb268e2a85d436b9eb6f47614c3cbc",
".git/hooks/pre-receive.sample": "2ad18ec82c20af7b5926ed9cea6aeedd",
".git/hooks/push-to-checkout.sample": "c7ab00c7784efeadad3ae9b228d4b4db",
".git/hooks/applypatch-msg.sample": "ce562e08d8098926a3862fc6e7905199",
".git/hooks/update.sample": "647ae13c682f7827c22f5fc08a03674e",
".git/hooks/commit-msg.sample": "579a3c1e12a1e74a98169175fb913012",
".git/hooks/pre-applypatch.sample": "054f9ffb8bfe04a599751cc757226dda",
".git/hooks/pre-commit.sample": "305eadbbcd6f6d2567e033ad12aabbc4",
".git/hooks/pre-push.sample": "2c642152299a94e05ea26eae11993b13",
".git/hooks/pre-rebase.sample": "56e45f2bcbc8226d2b4200f7c46371bf",
".git/refs/remotes/origin/ghpages": "d36fb8c3caaeeaf213b3c2072c9b24ca",
".git/refs/heads/ghpages": "d36fb8c3caaeeaf213b3c2072c9b24ca",
".git/logs/HEAD": "2e4f48e0325a04dfa0edcc40f8460d51",
".git/logs/refs/remotes/origin/ghpages": "120a11287e48d1ad1e23721fefc4cd71",
".git/logs/refs/heads/ghpages": "4e42978bb430d9e0b171fa68a06e4657",
".git/objects/02/1101eafa38b6c9faae82024ba8d3c39a2159e3": "37351d092bbc98954125a80dfb23f13f",
".git/objects/bd/c88b59db7fec54c5d3696514d49aff9c34dd2e": "cc689f675414db94188e2e7b4ea7532f",
".git/objects/85/6a39233232244ba2497a38bdd13b2f0db12c82": "eef4643a9711cce94f555ae60fecd388",
".git/objects/e7/4940e24389c921433e28e5927562e67460bd5a": "caeda771011fc98b1bc4f220a169aedf",
".git/objects/ca/5f1df35e5af939be868d1919c3facf770c89c6": "0d94f9ce38c6af4d97a8eefb331ab68b",
".git/objects/9d/d73ff57393ed6cabd7c29be001499bf31e54aa": "9920c5d5793c777136ae6cf9488618ba",
".git/objects/e0/a5bbb8e128aaf660bd2b2d081ffc3e50fc7069": "b853eb345c0b7a41d23b9e01be86400c",
".git/objects/e0/38c57c1dd41722598fe3e3fadb4404d20e2896": "005f1137dc96a6ab0ad7826a13a9ca4e",
".git/objects/e0/d3ddcb8964b1239f3f949134b7c53d6508362d": "42916843844be68e615c4b620c32d864",
".git/objects/9f/87b9deb44457abf81f92529f94f79b266dfa3e": "3aefdfa5412b92cfa6f0cff01a7bea40",
".git/objects/9f/672e08d0cf8f6a04b629e05bbeafba1e86ffa5": "82217463b1bc0a28b9b308f47ed4451e",
".git/objects/9f/37d195db00d91d94890a7936b19ffbeea9af73": "31c5ec989879c846c8b098639327b73c",
".git/objects/5a/6ddd3f707377cd6eb289c8f4e42dfa8daffe63": "57cb84de3628ea1cf5d546f73cd4f8d3",
".git/objects/31/589ace78e9d2d40f621406fbc907a95050cc37": "6a3b3fa4741fa9770120d50e7882a86a",
".git/objects/d6/9c56691fbdb0b7efa65097c7cc1edac12a6d3e": "868ce37a3a78b0606713733248a2f579",
".git/objects/d6/96998989c4d1a9a4a10d489fcf0e974b0da4ee": "27e31d91840be8da17e5528e0b51be70",
".git/objects/0a/df9f29c514dc20fb60745dc7e0c977bf846d3d": "9d130725bea3e2026c4f7f23eba3012b",
".git/objects/eb/9b4d76e525556d5d89141648c724331630325d": "37c0954235cbe27c4d93e74fe9a578ef",
".git/objects/eb/a2070803b22eaf336b513d5e0ca49377c8151d": "9fd9478f9ed5c5d02b0e2192486f9dc1",
".git/objects/65/3a2327d202835e07a04edf473fbbd2d234073b": "d5e17f378c07c8fce78d37fdd82ee5bf",
".git/objects/65/622b64ff6e5ad9f19d4139a731409864a405cb": "375f62174998719e4feac91b595c0d7a",
".git/objects/da/fd65422747502c19b5c74b4230282644d2169c": "d8a62caf99a372ff6c7692e143787ce3",
".git/objects/da/aa73e5cb9abd1a68da77e249f1ac76ae9aab11": "b9a28ac3f7c18dcd855d502e75dd7cd8",
".git/objects/cd/74af4563aadcfa142916af69e7a5d53b338c03": "0ad17f58feb9deb8bdd11ab3699cc5fd",
".git/objects/6b/e909fbf40b23748412f0ea89bf0fae827ed976": "5f118419157d9534688915220cc803f7",
".git/objects/6b/c211a033c90e45b3109e61b44abcbe6a991d1e": "85d66f68f5b5e3d732edcdf0429f966b",
".git/objects/7c/e2dd0f2aeb5c3724e612b43c32db5d346a1520": "79a65cb195cf9a2a57cfed8e9c8db7f8",
".git/objects/40/0d5b186c9951e294699e64671b9dde52c6f6a0": "f6bd3c7f9b239e8898bace6f9a7446b9",
".git/objects/f5/010cda95492006dae3638dfb01a8d0822a1e6a": "04eb9fcdf209b67f396e5ab84cb956e2",
".git/objects/f0/46e66918e5beaffe59f71c42d2725bb6b79432": "ad38da83227ed11c0d64ccc662821c2a",
".git/objects/f0/3f556a6bdacc6d0a9293bb2a9b6797388ab10a": "297c30f3fdd0fa2232b6b96eaff20ece",
".git/objects/d0/23371979cf1e985205df19078051c10de0a82d": "700b71074bad7afee32068791dec7442",
".git/objects/51/b9e6bf39db490faaa0cd0c055892c754cd1f97": "56099903c94c42d7cb21dbb032230146",
".git/objects/3c/f5ea9ba7c5459564fae323dfa6c3e854c97322": "72846c927781d41c763c785f2a840a2e",
".git/objects/4e/d924352ede6ce47285a268d8f653e30c32068b": "07835e99f8492b28e92aa08021bf998f",
".git/objects/5d/15fadf1864d70c7184fca7d3efde79cdf68af5": "79a44d8578cc18e3add64aa6a97f0da0",
".git/objects/f2/04823a42f2d890f945f70d88b8e2d921c6ae26": "6b47f314ffc35cf6a1ced3208ecc857d",
".git/objects/f2/9b4d48597f511aecef71401dbbdd09c5f95b97": "992c07fd90d35bea12d03bce35b374bf",
".git/objects/d2/8cea714cba96347ad91e6a98a8c0d50e5d093f": "38092e42b7b176fc08a9d7735c1d9dce",
".git/objects/04/305ed823ece5a3fd0c48d6bed48adca46863ed": "3f05fb8e114d8b5fe6cf2d29ec77728b",
".git/objects/bf/3fbd6da03de68835ce529288be99930fe769ee": "98cdcf88650db2bf16511755d5a11207",
".git/objects/b9/c36e492c6dab39bcd83f776c8eed59a8eeb25e": "370b79e136d364d47d877306c651a26e",
".git/objects/b9/2a0d854da9a8f73216c4a0ef07a0f0a44e4373": "f62d1eb7f51165e2a6d2ef1921f976f3",
".git/objects/cb/607b7d23841a891e2d503a57d8930dc1eb2e73": "20ca8fcaa6aa10c8f1be91a0c3d341e3",
".git/objects/ba/5317db6066f0f7cfe94eec93dc654820ce848c": "9b7629bf1180798cf66df4142eb19a4e",
".git/objects/45/83bb465dc439c8f1594949f24c5858c0277242": "f65bc0e587e45969d92a83165a84c5ff",
".git/objects/45/2917a5e4bd7cbbb5cbde358612aec08a8c0971": "ad495a9285fe1c5ffad8e40670f9b55d",
".git/objects/63/7948354f22e61cd90a9a969ee1847f3ffa7c43": "e24edff839504ed83f5a5c824715cec7",
".git/objects/f7/1254a7a97560c91a83ee4e2f591596715103a7": "9ac5c9ec6032304cb81b04f7696b19e3",
".git/objects/f7/98362ab4a3dacd50ba010f9d7f5b068f7750c8": "e6789d47611c2e3fbaa96e943f881136",
".git/objects/74/21f589299f5535a3bcc0850ce0870340e26016": "01932be6935c83981a1b1f150baba1fc",
".git/objects/16/5da67191b73406e15fc3e6cf7cda3c195dc735": "86cfac30d97fb45bba2f4417782645d6",
".git/objects/16/529ba7bf4fe9971fc856077258a7efca1fad9a": "b15623ab0f485abade52b6b0021e108d",
".git/objects/b3/dbc91a9cad0609a78105c3a745f571d852cc5a": "34bacb4741283052677a3d709533390b",
".git/objects/42/f394e1aafba8a875ecc981adef59249c3a671b": "3a76331b531c4ffcf5d6d04a3a1c5ac5",
".git/objects/a5/c563ddbb33d7d75e133e38b40dcf6705169150": "e91acc093b9a878249e0b20b9efce259",
".git/objects/a5/3efdf92300d180241adcd14d81d15a734c4e08": "cdce04155deb291d95d5b2a8a45a186e",
".git/objects/88/cfd48dff1169879ba46840804b412fe02fefd6": "e42aaae6a4cbfbc9f6326f1fa9e3380c",
".git/objects/88/588ee66499093dbb9a727f267945da7a42ff25": "e966bf6fe0d9669533a25b2a84c5a495",
".git/objects/32/aa3cae58a7432051fc105cc91fca4d95d1d011": "4f8558ca16d04c4f28116d3292ae263d",
".git/objects/9a/14132358a0995692610da3c5b6fc414ab51b9a": "d0459d727cbd8bf1953b62dbd0931796",
".git/objects/2a/42705bd5b1dbd22d78ff8e14919561f511cf6b": "2efd2febeecc92549215a5ec1e14f155",
".git/objects/2a/36e1b903bf058f73615749a177f742a79cfcbe": "d7099e24efc46e1416b5fcdfb866470b",
".git/objects/7e/75e882470d338dd3d1f62460754c08af092bdc": "5da8ac49c4aacc9d9dd546c481b57724",
".git/objects/54/e7822713aa79ca8186ff18e6eba06a41b67062": "1d3ea4d0ce20ad3a766bf90a8bb22c08",
".git/objects/b7/49bfef07473333cf1dd31e9eed89862a5d52aa": "36b4020dca303986cad10924774fb5dc",
".git/objects/b2/29a86f77293fdcfd0017d4d27b86a9b0d588aa": "57fb5bac2fa2cf2899f4750c6bf8f2a3",
".git/objects/25/8b3eee70f98b2ece403869d9fe41ff8d32b7e1": "05e38b9242f2ece7b4208c191bc7b258",
".git/objects/2f/45fbd805c31cd78aa72e3d488b20d624ab4c36": "16cbc52d12488dbba957e8ded49cbd65",
".git/objects/46/4ab5882a2234c39b1a4dbad5feba0954478155": "2e52a767dc04391de7b4d0beb32e7fc4",
".git/objects/46/7788c5a7bfbfe350cdd3d63dc6e4c7f4881d48": "40f003f3d1be4b2fceae5567bd59a947",
".git/objects/1d/461cf84501c030549ed1cdbc9c8325d423cf30": "abff0d72b0cbd0ac711581fb8638c3f8",
".git/objects/1d/85453a962236be40d927005937b23b507dc503": "f58177375532c5f80ff5026918e601b2",
".git/objects/08/01f18833bab3cc8e31271d03c3ddf1b586beee": "235d970b993dc2930fb2aa159bc926c3",
".git/objects/08/32d0db2def1613c1c45aa4fe9156a1c6b7d589": "e05df183e5eeaddf39672a2516f9c41d",
".git/objects/a8/085f6037b77626d485d9ce98a45bf925221aa8": "d69200419dceb66d952c5121acbdb23e",
".git/objects/a8/1c784f19aec73c000d243d9817bb858dec1d12": "6393b78c29fcdcf877380d376f399807",
".git/objects/a8/634861434b6ab6142fbf155b41ac0b53c6147e": "f45a591bbfebe10aa7aa69b7c1c208fc",
".git/objects/20/1afe538261bd7f9a38bed0524669398070d046": "82a4d6c731c1d8cdc48bce3ab3c11172",
".git/objects/ef/da1e1fa87ecda5ccbee614907373aa9cd231b8": "54ae067f561bf1264ee64790b11542e0",
".git/objects/ef/0fa712661348bdeef511b91cd6808c69c2c3ca": "91321b86e1896c1af22f77eb1f57105f",
".git/objects/ef/0b2dee10703c81da8009547f531b84a5f8e72a": "54dabef00dc90a1891e63df72d25e381",
".git/objects/95/740cfdaf6564561c0b47a7c6a76b16688ecf56": "3bcf49167f8dd3fbfb99cffae54a7c05",
".git/objects/1e/25fb4841dbfcbc6e4fa75d9417a4113ba250bc": "e91280155bc02e320c2a664e7fefc7b5",
".git/objects/33/bbb113fda405181818696de3c7f9487f6d8075": "771ced17201b7d11de95bc159fcf9f45",
".git/objects/d5/db3532f107a37ced14a124d7ff4cd022c400ed": "785e34de418e2ea07813b4bdcf59e7dd",
".git/objects/d5/bb50b3c3bc534b51ba035a5e8495ba7af5025b": "81d30e6f235d2cd1960b1a0d917b3043",
".git/objects/d5/b2dece9e72727d96b64974f2c96813f66f8858": "9cc34a4fbd33dcd1f527b2a8be0b6a4f",
".git/objects/76/c0878fcb05e48739ccdb17b29ed1f24b03076f": "9689e466ec8764c7f9a6ce9801256247",
".git/objects/f3/222ca02384061aba38b129bcb832bc9e3d5679": "28d5a66f7b14565b238ec50251738782",
".git/objects/86/5ac83cfe7a0d8d067cf2462cc73e36c8f0d627": "22599b0062d6623619e6c6eaab9db754",
".git/objects/b0/4fb6e85a6c8955acd5d44bd56f8b43b6f74114": "ad6deded14dede2ac5034241ffd34bc0",
".git/objects/b1/5ad935a6a00c2433c7fadad53602c1d0324365": "8f96f41fe1f2721c9e97d75caa004410",
".git/objects/0c/7d36c0a884e7525a3caa6bafadc5777800dfff": "617ba793fc02e3bfd27033606e3f220a",
".git/objects/d4/3532a2348cc9c26053ddb5802f0e5d4b8abc05": "3dad9b209346b1723bb2cc68e7e42a44",
".git/objects/1f/83307350213e7c24d3d32eb7eb614e1201a68e": "2e93f1c3116138dc14d168e3138be7b7",
".git/objects/1f/45b5bcaac804825befd9117111e700e8fcb782": "7a9d811fd6ce7c7455466153561fb479",
".git/objects/db/74861cd1ab993738dc9d65cc8e2eacbb47d9d1": "47bccb49eeb238b9eb01d430cd05df61",
".git/objects/de/5341a41654b7043850a621b456f97ae4c2f7d3": "fabadea347580dbcbda5c6d59d8e23f9",
".git/objects/90/bcfcf0a77ab618a826db0fd8b0942963b653af": "fc109675cdf1233dd6599a4c3c0a7a69",
".git/objects/90/2f8508448fc861853f127ccebfe59a56a31122": "6c4195ff61f55d0e51d8851556d750fc",
".git/objects/9e/b404046a0f6492924a125112114e81f282de99": "55c7fde16c62c327a8110efd796ea1e1",
".git/objects/09/93f94348c1bf4f73a2e743ec6fa9dd8c6fb558": "50ec767d1af708a68542dc0382c3c378",
".git/objects/ec/eb5c5d7e24910094b53369aba23680b989c492": "f6262dc2e8eb5be887b8d519670b6c84",
".git/objects/5c/998507b8c54c75d8ac7e243fb5d14496d3540a": "b6d3cb09d65698fa598ce6b86d6587f0",
".git/objects/f6/6ab8c99cc4be534f725c75a5f93dd4f0bee029": "408e30905ac1168ee9bfb865e1fbc5da",
".git/objects/f8/95101a0e2f5ebc4f4a3004f4d62f6c9461bc5c": "8c0b26d8a1fde9dcb98acefad3f27eb5",
".git/objects/84/0516208d35dcb4298847ab835e2ef84ada92fa": "36a4a870d8d9c1c623d8e1be329049da",
".git/objects/44/a8b8e41b111fcf913a963e318b98e7f6976886": "5014fdb68f6b941b7c134a717a3a2bc6",
".git/objects/44/1595a0940bc3f82fd319eb49539900d52f506b": "b60ae0d48b17e0a710513876dcedcbfb",
".git/objects/44/9570b53cc64ff07650a8d45c4c4516c86287cc": "d51b2e8eb4c6708ed9d1c833b9629afa",
".git/objects/bc/72fb0fed2078c52a20819775415d3cbea7f2e5": "28b2c3de5de8037659fdc314eed15f99",
".git/objects/aa/79128193af493c669fcd4f2df8643763ee82d8": "7da1aadb3862ff08a364ab60f391f126",
".git/objects/a3/787c42da175a7b9709385f609a7e5b4b34fc37": "553d2bf983005b3fccc58a5b4d02aa8f",
".git/objects/a2/c2c501d92cade4609fbff2a20d058036a0f07d": "5799cad65f96fe00122233a5625d5041",
".git/objects/99/b12fcd08eed06e178fdf32a93993b652951e7b": "1a24c70a08a24ae913c208b957be1c5b",
".git/objects/dc/863464162060f554eae2bcaad48d76d8094991": "5a3a9e65eb29deb4bbdaa9fa3fbfc433",
".git/objects/dc/aaefe207c24985bc4d2f52348045c8676b8154": "7f5bedf937f213aa75536a2738dd3082",
".git/objects/dc/1a5d97e4f9865924e5e6bb1f985a83ff2724f5": "8716e1dbc001d7819a7c320d2f6c52a1",
".git/objects/6e/443980efbb019578ed67e686a11aa7c79503b3": "d3bbf22262d54f6902367ef8e1e72277",
".git/objects/13/bde191cc57cfbb3da333837ec546b4a538ae6f": "1e68e4eff83684cf57d2f73c4bc202cd",
".git/objects/ac/d50b1d3e647d59be611629bff4891e85472075": "af1e0c18565d0f74dac231de3a85e9e1",
".git/objects/5b/09758e58083ea38c12a83a56c0535f77db6c33": "a0e88475bae13131fd60f161ce40e9ad",
".git/objects/24/1ee447ab2fdb89248110c9ac2e21a0b106979e": "428f261c06f89da591f46e8d9d74ffca",
".git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391": "c70c34cbeefd40e7c0149b7a0c2c64c2",
".git/objects/f9/bea67eafe22b35d21abbbebd3f4bda095c7a21": "fdb12ef78ec96e6a219ee80a64a35e3a",
".git/objects/3f/de9e19efdee445dba3ea4ebe7eaf89f9a274c7": "4c2d782802072576ba704211da35300f",
".git/objects/3f/a3c0659b3d7629dd4d5edeb3eeaecc774d12ee": "4aa263f39884b15c6a44cba784752a32",
".git/objects/43/7270129a5c8089a67b8216b89a53e93447b28a": "165e4a126a7df6f41a76e34298435291",
".git/objects/43/11c527ac4ed759513411f2e627a29b840581ca": "eea8019957185d1b53477b753a734b40",
".git/objects/8a/0557fb5393f5c3af68db7a678f19e7aea74846": "46e8c213b57e1327a58657d82548efa3",
".git/objects/8a/aa46ac1ae21512746f852a42ba87e4165dfdd1": "1d8820d345e38b30de033aa4b5a23e7b",
".git/objects/07/e885dfef062323352ae2409000968ef5341e10": "5c7520a1b07648544871b5569296680d",
".git/objects/3a/7525f2996a1138fe67d2a0904bf5d214bfd22c": "ab6f2f6356cba61e57d5c10c2e18739d",
".git/objects/75/0ce8504e974ddc6f26793565dff52ba2c703c6": "6ef6c260f72380e1993e0105034550ed",
".git/objects/ae/4e3e599c7aa175c75317da79110dee15e3bbec": "82ab21071fdd36333d61fbe675f28cc9",
".git/objects/ae/334f1bb3134254569f057efcff823132391d84": "99cbaad6e90ef9317cbaa46971bb627e",
".git/objects/4b/a1811ab322f1321fabaf73b493ddc553024a56": "c3a5b7a3d0e359fa6e51b95b9f107d04",
".git/objects/4b/036f4537a386e193c43be63378bd59fc04ff02": "8de0f7e05220f67fc5dec3172a1fd707",
".git/objects/d7/ce61b59010140b0eb2b59f5e4c211894fd4580": "6f6bbdb56c8cec2ec13c441ea415362c",
".git/objects/98/57c9b3b0448c92818efc5fda0f206b21914168": "ecbde07c564dabbec0f249821051b8af",
".git/objects/1b/76c11d7addf1236661ee44e45d65a085563d23": "3a99e00170de6f5d6e41936766d3bf25",
".git/objects/a9/4d41382c2823e1f7ee6348cd0792bbf83c60a0": "4bf0122fa9871f8db3e9c065ea2b6f4c",
".git/objects/1c/4f15d74be1463226b35ef39539cf0a6eba93a3": "60d4084bceb45f87734c1a87c5c9724c",
".git/objects/1c/0f4648dfa818bb84c4e5fe54000bcb7acdbce9": "8f79d1e85db31c61060126234c3e8591",
".git/info/exclude": "036208b4a1ab4a235d75c181e685e5a3",
".git/description": "a0a7c3fff21f2aea3cfa1d0316dd816c",
"manifest.json": "f22e80c2731f55c325cd24cad82ebbd4"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
