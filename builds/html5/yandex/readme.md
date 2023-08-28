## Run yandex local server
```
http-server --ssl -c-1 -p 8080 -a 127.0.0.1
```
Go to `https://localhost:8080`. (You needed to apply https accesse)

https://yandex.com/games/app/221438?draft=true&game_url=https://localhost:8080



## Fix index.html for SDK yandex

Header:
```html
	<!-- Extra CSS -->
	<style type='text/css'> #canvas {height: 90vh !important;}
	</style>
	<!-- end Extra Css -->

	<!-- Yandex.RTB -->
	<!-- <script src="https://yandex.com/games/sdk/v2"></script> -->
	<script src="https://yandex.ru/games/sdk/v2"></script> 
	<script>window.yaContextCb=window.yaContextCb||[]</script>
	<script src="https://yandex.ru/ads/system/context.js" async></script>
	<!-- end Yandex.RTB	-->
```

Body.After canvas:
```html
	<canvas id='canvas'>
		HTML5 canvas appears to be unsupported in the current browser.<br />
		Please try updating or use a different browser.
	</canvas>

	<!-- Yandex block scripts -->
	<!-- Yandex.FullScreen -->
	<div id="yandex_rtb_R-A-2294434-35" style="max-height: 80vh;">
		<div style="height: 72vh;"></div>
	</div>
	<script>
		window.yaContextCb.push(()=>{
			Ya.Context.AdvManager.render({
				renderTo: 'yandex_rtb_R-A-2294434-35',
				blockId: 'R-A-2294434-35'
			})
		});
	</script>
	<!-- Yandex.RTB R-A-2294434-34 -->
	<section style="position: absolute; width: 100%; height: 10%; bottom:0%; left:0%; background-color: plum;">
		<div id="yandex_rtb_R-A-2294434-34"></div>
		<script>
			window.yaContextCb.push(( )=> {
					Ya.Context.AdvManager.render({
				renderTo: 'yandex_rtb_R-A-2294434-34',
				blockId: 'R-A-2294434-34'
				})
		});
		</script>
	</section>
	<!-- end Yandex block scripts -->
```


## YA Content of ZIP archive:
1. cert.pem
2. index.apple-touch-icon.png
3. index.audio.worker.js
4. index.html 	# _Change css, added YA scripts_
5. index.icon.png
6. index.js
7. index.pck
8. index.png
9. index.wasm
10. key.pem



## Upload a new game version on the site gencrud
https://gencrud.com/ru/admin/filebrowser/browse/?&dir=ride_me
