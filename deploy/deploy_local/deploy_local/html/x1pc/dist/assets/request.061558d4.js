import{o as A,b as r,m,l as g}from"./index.28458106.js";import{o as C,n as E,u as l,q as d,_ as B,r as S,z as N}from"./zod.00b4b5c3.js";import{m as t}from"./vendor-antd.2261cd4e.js";const{t:F}=A.global,x=async e=>{try{return await r.delete("/api/x1/styleProcessParam/deleteParamInfo",e)}catch(u){console.error("deleteProcessParameter error:",u)}},T=async e=>{try{return await r.download("/api/x1/process/newExportTemplate",e)}catch(u){console.error("downloadProcessTemplate error:",u)}},h=async e=>{try{return await r.download("/api/x1/process/export",e)}catch(u){console.error("exportProcess error:",u)}},I=async e=>{try{const u=await r.get("/api/x1/Style/page",e);return u.code===0?u.data:(t.error(u.msg),[])}catch{return[]}},R=async e=>{const u=await r.get(`/api/x1/process/style/${e}`);return u.code===0?u.data:(t.error(u.msg),{})},v=async e=>{try{return await r.put("/api/x1/process",e)}catch(u){console.error("saveProcessInfo error:",u)}},O=async e=>{const u=await r.post("/api/x1/Style/save",e);return u.code===0?u:(t.error(u.msg),{})},b=async e=>{const u=await r.put("/api/x1/Style/update",e);return u.code===0?u:(t.error(u.msg),{})},M=async e=>{const u=await r.delete("/api/x1/Style/delete",e);return u.code===0?u:(t.error(u.msg),{})},L=async e=>{try{const u=await r.post("/api/x1/styleVideoRules",e);return u.code===0?!0:(t.error(u.msg),!1)}catch{return t.error(F("prompt.failed")),!1}},_=async e=>{try{const u=await r.get("/api/x1/styleVideoRules/getByStyleId",e);return u.code===0?u.data:(t.error(u.msg),{})}catch{return t.error(F("prompt.failed")),{}}},k=async e=>{try{const u=await r.get(`/api/x1/Style/${e}`);return u.code===0?u.data:(t.error(u.msg),{})}catch{return t.error(F("prompt.failed")),{}}},G=async()=>{const e=await r.get("/api/x1/Style/styleId");return e.code===0?e:(t.error(e.msg),{})},j=async e=>{try{const u=await r.delete("/api/x1/process",e);return u.code===0?u.data:(t.error(u.msg),{})}catch{return t.error(F("prompt.failed")),{}}},J=async e=>{const u=`
  # ROLE
  \u4F60\u662F\u4E00\u4E2A**\u4E25\u683C\u7684\u6570\u636E\u683C\u5F0F\u5316\u5F15\u64CE**,\u4F60\u7684\u552F\u4E00\u4EFB\u52A1\u662F\u63A5\u6536\u6570\u636E\u5E76\u8F93\u51FA**\u7EAF\u6587\u672C**\u7684JSON\u6570\u7EC4,**\u7981\u6B62**\u4EFB\u4F55\u683C\u5F0F\u5316\u3002

  # CONSTRAINTS
  **\u7EDD\u5BF9\u7981\u6B62**\u8F93\u51FA\u4EFB\u4F55Markdown\u6807\u8BB0\u7B26(\u5982 \`\`\`json\u3001\`\`\`\uFF09\u3001\u89E3\u91CA\u6027\u6587\u5B57\u3001\u95EE\u5019\u8BED\u6216\u603B\u7ED3\u3002
  **\u53EA\u8FD4\u56DE**\u539F\u59CB\u7684\u3001\u4EE5 [ \u5F00\u5934\u548C ] \u7ED3\u5C3E\u7684JSON\u5B57\u7B26\u4E32\u3002

  # TASK
  \u8BF7\u5C06\u5DE5\u5E8F\u8868\u683C\u6570\u636E\u6574\u7406\u6210\u5982\u4E0B\u683C\u5F0F\u7684JSON\u6570\u7EC4:

  # FIELD MAPPING
  \u8F93\u5165\u7684\u56FE\u7247\u4E2D\u7684\u8868\u5934\u4E0D\u4E00\u5B9A\u5B8C\u5168\u5339\u914D\u4E0B\u9762\u7684\u5B57\u6BB5,\u6CA1\u6709\u7684\u5C31\u4E0D\u8981\u8BC6\u522B,\u8FD4\u56DE\u7A7A\u5B57\u7B26\u4E32\u5373\u53EF
  \u5B57\u6BB5\u540D\u53EF\u80FD\u4E0D\u662F\u4E2D\u6587,\u4F60\u5C06\u5B57\u6BB5\u540D\u7FFB\u8BD1\u6210\u4E2D\u6587\u8FDB\u884C\u6BD4\u5BF9,\u610F\u601D\u76F8\u8FD1\u5373\u53EF\u3002
  - processName (String): \u5DE5\u5E8F\u540D\u79F0/\u7B80\u79F0,\u90FD\u6CA1\u6709\u7684\u60C5\u51B5\u4E0B\u53EF\u4EE5\u7528\u5DE5\u5E8F\u63CF\u8FF0\u4EE3\u66FF\u3002
  - partName (String): \u90E8\u4EF6/\u90E8\u4EF6\u540D\u79F0,\u975E\u5FC5\u586B,\u6CA1\u6709\u5C31\u4E0D\u586B\u3002
  - stdTime (Number/Null): \u6807\u51C6\u5DE5\u65F6(SAM/SMV) \u6839\u636E\u4E0A\u4E0B\u6587\u4FE1\u606F\u8F6C\u6362\u6210\u79D2(s)\u3002
  - processNo (String): \u5E8F\u53F7,\u53EA\u80FD\u662F\u6570\u5B57,\u4E0D\u8981\u4E71\u586B\u3002
  - level (String): \u5DE5\u5E8F\u7B49\u7EA7,\u975E\u5FC5\u586B,\u6CA1\u6709\u5C31\u4E0D\u586B\u3002
  - machineType (String/Null): \u673A\u5668\u7C7B\u578B,\u975E\u5FC5\u586B,\u6CA1\u6709\u5C31\u4E0D\u586B\u3002
  - cutNum (String/Null): \u526A\u7EBF\u6B21\u6570 \u4E0D\u662F\u6570\u5B57\u7684 \u9ED8\u8BA4\u4E3A0

  # OUTPUT FORMAT EXAMPLE
  [
    {
      "processName": "\u4E0A\u62C9\u94FE",
      "partName": "\u62C9\u94FE",
      "stdTime": 50,
      "processNo": "1",
      "level": "A",
      "machineType": null,
      "cutNum": 1
    }
  ]

  **\u8BF7\u5F00\u59CB\u4F60\u7684\u5DE5\u4F5C,\u76F4\u63A5\u8F93\u51FAJSON\u6570\u7EC4\u3002**
  `;try{if(!e||e.length===0)return console.warn("\u6CA1\u6709\u63D0\u4F9B\u5904\u7406\u540E\u7684\u6587\u4EF6\u6570\u636E"),[];const a={temperature:.1,responseMimeType:"application/json",responseSchema:{type:"ARRAY",items:{type:"OBJECT",properties:{processName:{type:"STRING"},partName:{type:"STRING"},stdTime:{nullable:!0,type:"NUMBER"},processNo:{type:"STRING"},level:{type:"STRING"},machineType:{nullable:!0,type:"STRING"},cutNum:{nullable:!0,type:"NUMBER"}},required:["processName","stdTime"]}}},n={model:"gemini-3-flash-preview",contents:[{role:"user",parts:[...e,{text:u}]}],generationConfig:a},s=await r.post("/api/x1/ai/generateAIAsync",n,{timeout:0}),{taskId:o}=s;if(!o)return console.error("\u4EFB\u52A1\u521B\u5EFA\u5931\u8D25\uFF0C\u672A\u8FD4\u56DEtaskId"),[];let c;const D=100;let p=0,i="PROCESSING";for(;p<D&&i!=="SUCCESS";){if(await new Promise(y=>setTimeout(y,2e4)),c=await r.get(`/api/x1/ai/generateAIAsync/result?taskId=${o}`),i=c.status,i==="SUCCESS")return c.data||[];if(i==="FAILED")return console.error("\u4EFB\u52A1\u6267\u884C\u5931\u8D25:",c.msg||"\u672A\u77E5\u9519\u8BEF"),[];p++}return console.error("\u4EFB\u52A1\u8D85\u65F6\uFF0C\u8D85\u8FC7\u6700\u5927\u91CD\u8BD5\u6B21\u6570"),[]}catch(a){return console.error("Gemini API \u8C03\u7528\u5931\u8D25:",a),[]}};async function U(e){const u=`
  # ROLE
  \u4F60\u662F\u4E00\u4E2A**\u4E25\u683C\u7684\u6570\u636E\u683C\u5F0F\u5316\u5F15\u64CE**,\u4F60\u7684\u552F\u4E00\u4EFB\u52A1\u662F\u63A5\u6536\u6570\u636E\u5E76\u8F93\u51FA**\u7EAF\u6587\u672C**\u7684JSON\u6570\u7EC4,**\u7981\u6B62**\u4EFB\u4F55\u683C\u5F0F\u5316\u3002

  # CONSTRAINTS
  **\u7EDD\u5BF9\u7981\u6B62**\u8F93\u51FA\u4EFB\u4F55Markdown\u6807\u8BB0\u7B26(\u5982 \`\`\`json\u3001\`\`\`\uFF09\u3001\u89E3\u91CA\u6027\u6587\u5B57\u3001\u95EE\u5019\u8BED\u6216\u603B\u7ED3\u3002
  **\u53EA\u8FD4\u56DE**\u539F\u59CB\u7684\u3001\u4EE5 [ \u5F00\u5934\u548C ] \u7ED3\u5C3E\u7684JSON\u5B57\u7B26\u4E32\u3002

  # TASK
  \u8BF7\u5C06\u5DE5\u5E8F\u8868\u683C\u6570\u636E\u6574\u7406\u6210\u5982\u4E0B\u683C\u5F0F\u7684JSON\u5BF9\u8C61:
  \u8F93\u5165\u7684\u56FE\u7247\u4E2D\u7684\u8868\u5934\u4E0D\u4E00\u5B9A\u5B8C\u5168\u5339\u914D\u4E0B\u9762\u7684\u5B57\u6BB5,\u6CA1\u6709\u7684\u5C31\u4E0D\u8981\u8BC6\u522B,\u8FD4\u56DE\u7A7A\u5B57\u7B26\u4E32\u5373\u53EF
  \u5B57\u6BB5\u540D\u53EF\u80FD\u4E0D\u662F\u4E2D\u6587,\u4F60\u5C06\u5B57\u6BB5\u540D\u7FFB\u8BD1\u6210\u4E2D\u6587\u8FDB\u884C\u6BD4\u5BF9,\u610F\u601D\u76F8\u8FD1\u5373\u53EF\u3002
  \u4E25\u7981\u6839\u636E\u5355\u5143\u683C\u5185\u5BB9\u63A8\u6D4B\u5217\u7684\u542B\u4E49\u3002\u5982\u679C\u8868\u5934\u7F3A\u5931,\u5C31\u9ED8\u8BA4\u7A7A\u5B57\u7B26\u4E32
  # FIELD MAPPING
  - processName (String): \u5DE5\u5E8F\u540D\u79F0/\u7B80\u79F0,\u90FD\u6CA1\u6709\u7684\u60C5\u51B5\u4E0B\u53EF\u4EE5\u7528\u5DE5\u5E8F\u63CF\u8FF0\u4EE3\u66FF\u3002
  - partName (String): \u90E8\u4EF6/\u90E8\u4EF6\u540D\u79F0,\u5982\u679C\u8868\u5934\u7F3A\u5931,\u5C31\u9ED8\u8BA4\u7A7A\u5B57\u7B26\u4E32\u3002
  - stdTime (Number/Null): \u6807\u51C6\u5DE5\u65F6(SAM/SMV) \u6839\u636E\u4E0A\u4E0B\u6587\u4FE1\u606F\u8F6C\u6362\u6210\u79D2(s),\u5982\u679C\u8BC6\u522B\u4E0D\u5230\u5355\u4F4D\u6216\u6570\u5B57\u8F83\u5C0F\u9ED8\u8BA4\u5355\u4F4D\u4E3A\u5206\u949F\u8F93\u51FA\u7ED3\u679C\u5728\u8BC6\u522B\u7684\u6570\u5B57\u57FA\u7840\u4E0A\u4E58\u4EE560\u3002
  - processNo (String): \u5E8F\u53F7,\u53EA\u80FD\u662F\u6570\u5B57,\u4E0D\u8981\u4E71\u586B\u3002
  - level (String): \u5DE5\u5E8F\u7B49\u7EA7,\u975E\u5FC5\u586B,\u6CA1\u6709\u5C31\u4E0D\u586B\u3002
  - machineType (String/Null): \u673A\u5668\u7C7B\u578B,\u975E\u5FC5\u586B,\u6CA1\u6709\u5C31\u4E0D\u586B\u3002
  - cutNum (String/Null): \u526A\u7EBF\u6B21\u6570 \u4E0D\u662F\u6570\u5B57\u7684 \u9ED8\u8BA4\u4E3A0

  # OUTPUT FORMAT EXAMPLE
  [
    {
      "processName": "\u4E0A\u62C9\u94FE",
      "partName": "\u62C9\u94FE",
      "stdTime": 50,
      "processNo": "1",
      "level": "A",
      "machineType": null,
      "cutNum": 1
    }
  ]

  **\u8BF7\u5F00\u59CB\u4F60\u7684\u5DE5\u4F5C,\u76F4\u63A5\u8F93\u51FAJSON\u5BF9\u8C61\u3002**
  `,a=C({processName:E(),partName:E(),stdTime:l([d(),B()]),processNo:E(),level:E(),machineType:l([E(),B()]),cutNum:l([E(),B()])}),n=C({processes:S(a)});try{const s=e.some(o=>o.type==="image_url")?"image_url":"text";if(s==="image_url"){const o={model:"qwen3-vl-plus",messages:[{role:"user",content:[...e,{type:"text",text:u}]}],parameters:{vl_high_resolution_images:!0,temperature:.1,max_tokens:512}};return await r.post("/api/x1/ai/dashScope-bailian",o,{timeout:0})||[]}if(s==="text"){const o={model:"qwen3-vl-plus",messages:[{role:"user",content:[...e,{type:"text",text:u}]}],parameters:{vl_high_resolution_images:!0,temperature:.1,max_tokens:512},response_format:N(n,"response")};return await r.post("/api/x1/ai/dashScope-bailian",o,{timeout:0})||[]}}catch(s){return console.error("\u8C03\u7528\u5931\u8D25\uFF1A",s),[]}}const V=async e=>{const u=await r.get("/api/x1/deviceModel/listTree",e);return u.code===0?u.data:(t.error(u.msg),[])},q=async e=>{const u=await r.get("/api/x1/category/TreeCategory",e);return u.code===0?u.data:(t.error(u.msg),[])},$=async e=>{const u=await r.get("/api/x1/category/TreeFabricCategory",e);return u.code===0?u.data:(t.error(u.msg),[])},z=async e=>{const u=await r.get("/api/x1/version/list",e);return u.code===0?u.data:(t.error(u.msg),[])},K=async e=>{const u=await r.get("/api/param/param/getParamInfo",e);return u.code===0?u.data||[]:(t.error(u.msg),[])},X=async e=>{const u=await r.post("/api/x1/styleProcessParam/copyCategoryParam",e);return u.code===0?u:(t.error(u.msg),[])},Q=async e=>{const u=await r.get("/api/x1/styleProcessParam/getParamInfo",e);return u.code===0?u:(t.error(u.msg),[])},Y=async e=>{const u=await r.post("/api/x1/styleProcessParam/sendPara",e);return u.code===0?u:(t.error(u.msg),[])},H=async e=>{var a;const u=new FormData;u.append("file",e);try{const s=await(await fetch(`api/sys/oss/upload?token=${m()}`,{method:"POST",headers:{"Accept-Language":g(),token:m()},body:u})).json();return(s==null?void 0:s.code)===0?((a=s==null?void 0:s.data)==null?void 0:a.src)||"":(t.error((s==null?void 0:s.msg)||F("prompt.failed")),"")}catch(n){return console.error("uploadImage error:",n),t.error(F("prompt.failed")),""}};export{O as a,R as b,M as c,T as d,h as e,U as f,I as g,J as h,x as i,X as j,q as k,j as l,H as m,k as n,G as o,Q as p,V as q,$ as r,v as s,K as t,b as u,z as v,Y as w,_ as x,L as y};
