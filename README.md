# What is hai-vr/Unlit_WF_ShaderSuite_ForwardAdd?

This is a modified version of [whiteflare/Unlit_WF_ShaderSuite](https://github.com/whiteflare/Unlit_WF_ShaderSuite) to support ForwardAdd.

You can find more details about what motivates the modification of this shader [within this article on Notion](https://hai-vr.notion.site/UnlitWF-Untoon-ForwardAdd-56b9f842ba22485f9ee351f730b07506).

- See: https://hai-vr.notion.site/UnlitWF-Untoon-ForwardAdd-56b9f842ba22485f9ee351f730b07506

https://user-images.githubusercontent.com/60819407/146657653-719eae5c-07e9-4816-9379-c92e55263099.mp4

By design, `whiteflare/Unlit_WF_ShaderSuite` does not support `ForwardAdd` pass since [realtime lights are handled in the `ForwardBase` pass](https://twitter.com/whiteflare_vrc/status/1457915514341117954).

Consequently, spotlights which use cookies are not supported by `UnlitWF/Untoon`. This causes the material to be incorrectly bright with disco balls.

![image](https://user-images.githubusercontent.com/60819407/146675568-e5b36865-95ac-4996-ab65-9dcb625c3632.png)

This repository contains additional modified shaders which will use a `ForwardAdd` pass for realtime lights so that materials don't look incorrect under disco balls.

Pros:
- The shader will not stand out under spotlights, especially disco balls.

Cons:
- **This makes the shader more expensive to render** when under realtime lights.
- Even in the absence of spotlights, the appearance of the ForwardAdd variant material will be different than the same material settings with a non-ForwardAdd variant.

![image](https://user-images.githubusercontent.com/60819407/146675559-32c39cfd-6907-4662-9d24-7d3e320440bf.png)

Before:

https://user-images.githubusercontent.com/60819407/146657447-65ceee80-8b33-4d47-8ae4-0f4bc79e92be.mp4

After:

https://user-images.githubusercontent.com/60819407/146657451-bdf14ff3-0c2b-4a87-904e-b3e535ce99a9.mp4

```text
================================================================
Unlit_WF_ShaderSuite
================================================================

UnlitWF/UnToon は、テクスチャをそのまま描画するUnlitシェーダに、さまざまな効果を追加する発想で設計されたトゥーンシェーダです。
光源に応じた明度/色調の調整はもちろん、NormalMap/MetallicMap/Matcapなどの各種効果、階調陰/アウトラインといったトゥーン描画を得意としています。
簡単な設定でダイナミックに変化する描画をお楽しみください。

シェーダは MIT License にて頒布します。
改変、再頒布、有償/無償のモデルやアセットへの同梱など、MIT License のもとで自由に使用することができます。

================================================================

The MIT License

Copyright 2018-2021 whiteflare.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
