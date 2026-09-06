import x from"./chat-dialog.d7179647.js";import w from"./index.835e402d.js";import{_ as k}from"./index.36428c14.js";import{r as v,S as C,U as D,V as _,$ as h,A as u,Z as g,a0 as S}from"./vlib.e7835980.js";import"./monacoeditor.1e988593.js";import"./lodash.4f76ce88.js";import"./lib.5e3cf1d3.js";import"./question.7b6d7822.js";import"./answer.e310e315.js";import"./chat-input-area.3f09f5fa.js";import"./try-to-ask.6cef1fc2.js";var m=[{event:"workflow_started",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"92cf8a54-58de-41f0-941d-3984c26ffd43",workflow_id:"d9191466-9fe0-4e39-aedc-11fa615ad1ab",inputs:{"sys.files":[],"sys.user_id":"1027","sys.app_id":"83a648c7-8ec0-4da0-83d9-cf43f86f6f4c","sys.workflow_id":"d9191466-9fe0-4e39-aedc-11fa615ad1ab","sys.workflow_run_id":"92cf8a54-58de-41f0-941d-3984c26ffd43","sys.query":"\u8BED\u8A00: zh-CN,\u6B3E\u5F0F\u540D\u79F0\u662Fstyle-003\u7684\u6B3E\u5F0F\u4FE1\u606F\uFF0C\u79DF\u6237\u662F1027","sys.dialogue_count":0},created_at:1761197034}},{event:"node_started",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"019a0f86-0a40-7ed8-b4f3-fbbd4fdc6d15",node_id:"1752636289395",node_type:"start",title:"\u5F00\u59CB",index:1,predecessor_node_id:null,inputs:null,created_at:1761197034,extras:{},parallel_id:null,parallel_start_node_id:null,parent_parallel_id:null,parent_parallel_start_node_id:null,iteration_id:null,loop_id:null,parallel_run_id:null,agent_strategy:null}},{event:"node_finished",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"019a0f86-0a40-7ed8-b4f3-fbbd4fdc6d15",node_id:"1752636289395",node_type:"start",title:"\u5F00\u59CB",index:1,predecessor_node_id:null,inputs:{"sys.files":[],"sys.user_id":"1027","sys.app_id":"83a648c7-8ec0-4da0-83d9-cf43f86f6f4c","sys.workflow_id":"d9191466-9fe0-4e39-aedc-11fa615ad1ab","sys.workflow_run_id":"92cf8a54-58de-41f0-941d-3984c26ffd43","sys.query":"\u8BED\u8A00: zh-CN,\u6B3E\u5F0F\u540D\u79F0\u662Fstyle-003\u7684\u6B3E\u5F0F\u4FE1\u606F\uFF0C\u79DF\u6237\u662F1027","sys.conversation_id":"10fc41b9-50d5-4323-81e4-ecbb2a087100","sys.dialogue_count":0},process_data:null,outputs:{"sys.files":[],"sys.user_id":"1027","sys.app_id":"83a648c7-8ec0-4da0-83d9-cf43f86f6f4c","sys.workflow_id":"d9191466-9fe0-4e39-aedc-11fa615ad1ab","sys.workflow_run_id":"92cf8a54-58de-41f0-941d-3984c26ffd43","sys.query":"\u8BED\u8A00: zh-CN,\u6B3E\u5F0F\u540D\u79F0\u662Fstyle-003\u7684\u6B3E\u5F0F\u4FE1\u606F\uFF0C\u79DF\u6237\u662F1027","sys.conversation_id":"10fc41b9-50d5-4323-81e4-ecbb2a087100","sys.dialogue_count":0},status:"succeeded",error:null,elapsed_time:.04461,execution_metadata:{},created_at:1761197034,finished_at:1761197034,files:[],parallel_id:null,parallel_start_node_id:null,parent_parallel_id:null,parent_parallel_start_node_id:null,iteration_id:null,loop_id:null}},{event:"node_started",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"019a0f86-0a4f-7ef0-83cb-4b32b792959c",node_id:"1760682753507",node_type:"if-else",title:"\u6761\u4EF6\u5206\u652F",index:2,predecessor_node_id:"1752636289395",inputs:null,created_at:1761197034,extras:{},parallel_id:null,parallel_start_node_id:null,parent_parallel_id:null,parent_parallel_start_node_id:null,iteration_id:null,loop_id:null,parallel_run_id:null,agent_strategy:null}},{event:"node_finished",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"019a0f86-0a4f-7ef0-83cb-4b32b792959c",node_id:"1760682753507",node_type:"if-else",title:"\u6761\u4EF6\u5206\u652F",index:2,predecessor_node_id:"1752636289395",inputs:{conditions:[{actual_value:"\u8BED\u8A00: zh-CN,\u6B3E\u5F0F\u540D\u79F0\u662Fstyle-003\u7684\u6B3E\u5F0F\u4FE1\u606F\uFF0C\u79DF\u6237\u662F1027",expected_value:"\u79DF\u6237",comparison_operator:"contains"}]},process_data:{condition_results:[{group:{case_id:"true",logical_operator:"and",conditions:[{variable_selector:["sys","query"],comparison_operator:"contains",value:"\u79DF\u6237",sub_variable_condition:null}]},results:[!0],final_result:!0}]},outputs:{result:!0,selected_case_id:"true"},status:"succeeded",error:null,elapsed_time:.031015,execution_metadata:{},created_at:1761197034,finished_at:1761197034,files:[],parallel_id:null,parallel_start_node_id:null,parent_parallel_id:null,parent_parallel_start_node_id:null,iteration_id:null,loop_id:null}},{event:"node_started",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"019a0f86-0a72-76b8-a8ff-a12f5287ab5a",node_id:"1752642748005",node_type:"agent",title:"Agent",index:3,predecessor_node_id:"1760682753507",inputs:null,created_at:1761197034,extras:{},parallel_id:null,parallel_start_node_id:null,parent_parallel_id:null,parent_parallel_start_node_id:null,iteration_id:null,loop_id:null,parallel_run_id:null,agent_strategy:{name:"mcp_sse_ReAct",icon:"c1f2abda13626b854a19c598a21605c24fdfd999d9e455885d9da51155bf44a0.svg"}}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"697c24c2-3a9a-4923-957c-f3040dce63ec",label:"ROUND 1",parent_id:null,error:null,status:"start",data:{},metadata:{started_at:3903739788031501e-9},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"79e6f578-688a-42d0-b263-cdd39a9d4015",label:"qwen-plus-latest Thought",parent_id:"697c24c2-3a9a-4923-957c-f3040dce63ec",error:null,status:"start",data:{},metadata:{provider:"langgenius/tongyi/tongyi",started_at:3903739789696209e-9,icon:"7d40d629e02c01404af94652a8684f9aaab0da105182fc16fafe0da4e183dd9e.png",icon_dark:null},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"79e6f578-688a-42d0-b263-cdd39a9d4015",label:"qwen-plus-latest Thought",parent_id:"697c24c2-3a9a-4923-957c-f3040dce63ec",error:null,status:"success",data:{action:"getStyleInfo",action_input:{style_name:"style-003",tenant_code:"1027"},thought:""},metadata:{currency:"RMB",elapsed_time:2.3920080680400133,finished_at:3903742181703482e-9,provider:"langgenius/tongyi/tongyi",started_at:3903739789696209e-9,total_price:"0.00678",total_tokens:8406,icon:"7d40d629e02c01404af94652a8684f9aaab0da105182fc16fafe0da4e183dd9e.png",icon_dark:null},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"2dc6fb01-3268-4435-af77-ffb812845719",label:"CALL getStyleInfo",parent_id:"697c24c2-3a9a-4923-957c-f3040dce63ec",error:null,status:"start",data:{},metadata:{provider:"",started_at:3903742182027412e-9},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"2dc6fb01-3268-4435-af77-ffb812845719",label:"CALL getStyleInfo",parent_id:"697c24c2-3a9a-4923-957c-f3040dce63ec",error:null,status:"success",data:{output:`{
  "style_info": {
    "id": 1935514489024901122,
    "style_no": "KS-20250619-2",
    "style_name": "style-003",
    "images": "<http://x1.aliothcloud.com/oss/x1/download/images/1027/simple/20250630/c64171d7062f46ec80a73721e32fb2ba.png",
>    "thumbnail": "<http://x1.aliothcloud.com/oss/x1/download/images/1001/simple/20250630/9b21073c591d4b3a98517612e9bb727a.png",
>    "processes": [
      {
        "id": 1935514750803996673,
        "process_no": 1,
        "process_name": "\u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E",
        "part_name": "\u5E3D\u5B50",
        "std_time": 150.0,
        "level": "A",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750808190977,
        "process_no": 2,
        "process_name": "\u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03",
        "part_name": "\u5E3D\u5B50",
        "std_time": 11.0,
        "level": "C",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750808190978,
        "process_no": 3,
        "process_name": "\u5E3D\u53E3\u538B\u7EBF",
        "part_name": "\u5E3D\u5B50",
        "std_time": 14.0,
        "level": "C",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385281,
        "process_no": 4,
        "process_name": "\u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9",
        "part_name": "\u8896\u53E3",
        "std_time": 16.0,
        "level": "B",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385282,
        "process_no": 5,
        "process_name": "\u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9",
        "part_name": "\u8896\u53E3",
        "std_time": 20.0,
        "level": "B",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385283,
        "process_no": 6,
        "process_name": "\u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9",
        "part_name": "\u8896\u53E3",
        "std_time": 21.0,
        "level": "C",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385284,
        "process_no": 7,
        "process_name": "\u56DB\u7EBF\u88C5\u63D2\u80A9\u8896",
        "part_name": "\u7EC4\u88C5",
        "std_time": 14.0,
        "level": "D",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      }
    ]
  },
  "processes": [
    {
      "id": 1935514750803996673,
      "process_no": 1,
      "process_name": "\u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E",
      "part_name": "\u5E3D\u5B50",
      "std_time": 150.0,
      "level": "A",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750808190977,
      "process_no": 2,
      "process_name": "\u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03",
      "part_name": "\u5E3D\u5B50",
      "std_time": 11.0,
      "level": "C",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750808190978,
      "process_no": 3,
      "process_name": "\u5E3D\u53E3\u538B\u7EBF",
      "part_name": "\u5E3D\u5B50",
      "std_time": 14.0,
      "level": "C",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385281,
      "process_no": 4,
      "process_name": "\u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9",
      "part_name": "\u8896\u53E3",
      "std_time": 16.0,
      "level": "B",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385282,
      "process_no": 5,
      "process_name": "\u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9",
      "part_name": "\u8896\u53E3",
      "std_time": 20.0,
      "level": "B",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385283,
      "process_no": 6,
      "process_name": "\u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9",
      "part_name": "\u8896\u53E3",
      "std_time": 21.0,
      "level": "C",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385284,
      "process_no": 7,
      "process_name": "\u56DB\u7EBF\u88C5\u63D2\u80A9\u8896",
      "part_name": "\u7EC4\u88C5",
      "std_time": 14.0,
      "level": "D",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    }
  ],
  "message": "\u6210\u529F\u83B7\u53D6\u79DF\u62371027\u4E0B\u6B3E\u5F0F\u4FE1\u606F: ID=1935514489024901122, \u6B3E\u53F7=KS-20250619-2, \u6B3E\u540D=style-003, \u5DE5\u5E8F\u6570\u91CF=7"
}`,tool_call_args:{style_name:"style-003",tenant_code:"1027"},tool_name:"getStyleInfo"},metadata:{elapsed_time:.026176797691732645,finished_at:3903742208174572e-9,provider:"",started_at:3903742181998146e-9},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"697c24c2-3a9a-4923-957c-f3040dce63ec",label:"ROUND 1",parent_id:null,error:null,status:"success",data:{action_input:{style_name:"style-003",tenant_code:"1027"},action_name:"getStyleInfo",observation:`{
  "style_info": {
    "id": 1935514489024901122,
    "style_no": "KS-20250619-2",
    "style_name": "style-003",
    "images": "<http://x1.aliothcloud.com/oss/x1/download/images/1027/simple/20250630/c64171d7062f46ec80a73721e32fb2ba.png",
>    "thumbnail": "<http://x1.aliothcloud.com/oss/x1/download/images/1001/simple/20250630/9b21073c591d4b3a98517612e9bb727a.png",
>    "processes": [
      {
        "id": 1935514750803996673,
        "process_no": 1,
        "process_name": "\u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E",
        "part_name": "\u5E3D\u5B50",
        "std_time": 150.0,
        "level": "A",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750808190977,
        "process_no": 2,
        "process_name": "\u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03",
        "part_name": "\u5E3D\u5B50",
        "std_time": 11.0,
        "level": "C",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750808190978,
        "process_no": 3,
        "process_name": "\u5E3D\u53E3\u538B\u7EBF",
        "part_name": "\u5E3D\u5B50",
        "std_time": 14.0,
        "level": "C",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385281,
        "process_no": 4,
        "process_name": "\u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9",
        "part_name": "\u8896\u53E3",
        "std_time": 16.0,
        "level": "B",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385282,
        "process_no": 5,
        "process_name": "\u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9",
        "part_name": "\u8896\u53E3",
        "std_time": 20.0,
        "level": "B",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385283,
        "process_no": 6,
        "process_name": "\u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9",
        "part_name": "\u8896\u53E3",
        "std_time": 21.0,
        "level": "C",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      },
      {
        "id": 1935514750812385284,
        "process_no": 7,
        "process_name": "\u56DB\u7EBF\u88C5\u63D2\u80A9\u8896",
        "part_name": "\u7EC4\u88C5",
        "std_time": 14.0,
        "level": "D",
        "machine_type": "",
        "pre_process_ids": null,
        "line_color": null,
        "image": "",
        "process_standards": null
      }
    ]
  },
  "processes": [
    {
      "id": 1935514750803996673,
      "process_no": 1,
      "process_name": "\u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E",
      "part_name": "\u5E3D\u5B50",
      "std_time": 150.0,
      "level": "A",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750808190977,
      "process_no": 2,
      "process_name": "\u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03",
      "part_name": "\u5E3D\u5B50",
      "std_time": 11.0,
      "level": "C",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750808190978,
      "process_no": 3,
      "process_name": "\u5E3D\u53E3\u538B\u7EBF",
      "part_name": "\u5E3D\u5B50",
      "std_time": 14.0,
      "level": "C",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385281,
      "process_no": 4,
      "process_name": "\u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9",
      "part_name": "\u8896\u53E3",
      "std_time": 16.0,
      "level": "B",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385282,
      "process_no": 5,
      "process_name": "\u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9",
      "part_name": "\u8896\u53E3",
      "std_time": 20.0,
      "level": "B",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385283,
      "process_no": 6,
      "process_name": "\u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9",
      "part_name": "\u8896\u53E3",
      "std_time": 21.0,
      "level": "C",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    },
    {
      "id": 1935514750812385284,
      "process_no": 7,
      "process_name": "\u56DB\u7EBF\u88C5\u63D2\u80A9\u8896",
      "part_name": "\u7EC4\u88C5",
      "std_time": 14.0,
      "level": "D",
      "machine_type": "",
      "pre_process_ids": null,
      "line_color": null,
      "image": "",
      "process_standards": null
    }
  ],
  "message": "\u6210\u529F\u83B7\u53D6\u79DF\u62371027\u4E0B\u6B3E\u5F0F\u4FE1\u606F: ID=1935514489024901122, \u6B3E\u53F7=KS-20250619-2, \u6B3E\u540D=style-003, \u5DE5\u5E8F\u6570\u91CF=7"
}`,thought:""},metadata:{currency:"RMB",elapsed_time:2.4208524897694588,finished_at:3903742208883641e-9,started_at:3903739788031501e-9,total_price:"0.00678",total_tokens:8406},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"cf59d48c-d6d4-4a14-bcf8-f64aa2b97352",label:"ROUND 2",parent_id:null,error:null,status:"start",data:{},metadata:{started_at:3903742209117316e-9},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"8897a731-9957-4674-8fe5-190b27d71886",label:"qwen-plus-latest Thought",parent_id:"cf59d48c-d6d4-4a14-bcf8-f64aa2b97352",error:null,status:"start",data:{},metadata:{provider:"langgenius/tongyi/tongyi",started_at:3903742210468059e-9,icon:"7d40d629e02c01404af94652a8684f9aaab0da105182fc16fafe0da4e183dd9e.png",icon_dark:null},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"8897a731-9957-4674-8fe5-190b27d71886",label:"qwen-plus-latest Thought",parent_id:"cf59d48c-d6d4-4a14-bcf8-f64aa2b97352",error:null,status:"success",data:{action:"Final Answer",action_input:`### \u6B3E\u5F0F\u4FE1\u606F

| \u9879\u76EE\u540D\u79F0 | \u5177\u4F53\u6570\u636E |
| -------- | -------- |
| \u6B3E\u5F0F\u540D\u79F0 | style-003 |
| \u6B3E\u53F7 | KS-20250619-2 |
| \u56FE\u7247 | ![](http://x1.aliothcloud.com/oss/x1/download/images/1027/simple/20250630/c64171d7062f46ec80a73721e32fb2ba.png) |

### \u5DE5\u5E8F\u4FE1\u606F

| \u5E8F\u53F7 | \u5DE5\u5E8F\u540D\u79F0 | \u90E8\u4F4D | \u6807\u51C6\u65F6\u95F4\uFF08\u79D2\uFF09 | \u7B49\u7EA7 |
| --- | -------- | ---- | -------------- | ---- |
| 1 | \u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E | \u5E3D\u5B50 | 150.0 | A |
| 2 | \u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03 | \u5E3D\u5B50 | 11.0 | C |
| 3 | \u5E3D\u53E3\u538B\u7EBF | \u5E3D\u5B50 | 14.0 | C |
| 4 | \u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9 | \u8896\u53E3 | 16.0 | B |
| 5 | \u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9 | \u8896\u53E3 | 20.0 | B |
| 6 | \u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9 | \u8896\u53E3 | 21.0 | C |
| 7 | \u56DB\u7EBF\u88C5\u63D2\u80A9\u8896 | \u7EC4\u88C5 | 14.0 | D |`,thought:"I am thinking about how to help you"},metadata:{currency:"RMB",elapsed_time:11.614876111969352,finished_at:390375382534376e-8,provider:"langgenius/tongyi/tongyi",started_at:3903742210468059e-9,total_price:"0.008962",total_tokens:10628,icon:"7d40d629e02c01404af94652a8684f9aaab0da105182fc16fafe0da4e183dd9e.png",icon_dark:null},node_id:"1752642748005"}},{event:"agent_log",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",data:{node_execution_id:"fdec2ca2-18cb-4681-b768-ee9fb0d20ddb",id:"cf59d48c-d6d4-4a14-bcf8-f64aa2b97352",label:"ROUND 2",parent_id:null,error:null,status:"success",data:{action_input:`### \u6B3E\u5F0F\u4FE1\u606F

| \u9879\u76EE\u540D\u79F0 | \u5177\u4F53\u6570\u636E |
| -------- | -------- |
| \u6B3E\u5F0F\u540D\u79F0 | style-003 |
| \u6B3E\u53F7 | KS-20250619-2 |
| \u56FE\u7247 | ![](http://x1.aliothcloud.com/oss/x1/download/images/1027/simple/20250630/c64171d7062f46ec80a73721e32fb2ba.png) |

### \u5DE5\u5E8F\u4FE1\u606F

| \u5E8F\u53F7 | \u5DE5\u5E8F\u540D\u79F0 | \u90E8\u4F4D | \u6807\u51C6\u65F6\u95F4\uFF08\u79D2\uFF09 | \u7B49\u7EA7 |
| --- | -------- | ---- | -------------- | ---- |
| 1 | \u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E | \u5E3D\u5B50 | 150.0 | A |
| 2 | \u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03 | \u5E3D\u5B50 | 11.0 | C |
| 3 | \u5E3D\u53E3\u538B\u7EBF | \u5E3D\u5B50 | 14.0 | C |
| 4 | \u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9 | \u8896\u53E3 | 16.0 | B |
| 5 | \u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9 | \u8896\u53E3 | 20.0 | B |
| 6 | \u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9 | \u8896\u53E3 | 21.0 | C |
| 7 | \u56DB\u7EBF\u88C5\u63D2\u80A9\u8896 | \u7EC4\u88C5 | 14.0 | D |`,action_name:"Final Answer",observation:"",thought:"I am thinking about how to help you"},metadata:{currency:"RMB",elapsed_time:11.616904302034527,finished_at:3903753826021068e-9,started_at:3903742209117316e-9,total_price:"0.008962",total_tokens:10628},node_id:"1752642748005"}},{event:"node_started",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",workflow_run_id:"92cf8a54-58de-41f0-941d-3984c26ffd43",data:{id:"019a0f86-42df-7526-8f7a-723ece3e96a9",node_id:"llm",node_type:"llm",title:"LLM",index:4,predecessor_node_id:"1752642748005",inputs:null,created_at:1761197048,extras:{},parallel_id:null,parallel_start_node_id:null,parent_parallel_id:null,parent_parallel_start_node_id:null,iteration_id:null,loop_id:null,parallel_run_id:null,agent_strategy:null}},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"###",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u6B3E",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"\u5F0F\u4FE1\u606F",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:`

|`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u9879\u76EE\u540D\u79F0 | \u5177",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:`\u4F53\u6570\u636E |
| --------`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:` | -------- |
|`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u6B3E\u5F0F\u540D\u79F0 | style",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:`-003 |
`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"| \u6B3E\u53F7 |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" KS-2025",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"0619-2",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:` |
| \u56FE\u7247 | !`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"iothcloud.com/oss",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"/x1/download/images/1",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"027/simple/2",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"025063",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"0/c6417",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"1d7062",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"f46ec",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"80a73",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"721e32",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:`fb2ba.png) |

`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:`### \u5DE5\u5E8F\u4FE1\u606F

`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"| \u5E8F\u53F7 |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u5DE5\u5E8F\u540D\u79F0 |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u90E8\u4F4D |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u6807\u51C6\u65F6\u95F4\uFF08\u79D2\uFF09",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:` | \u7B49\u7EA7 |
`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"| --- | -------- |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" ---- | -------------- | ----",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:` |
| 1 |`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u6C14\u773C\u8F66\u5E3D\u53E3",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"\u5145\u6D1E | \u5E3D",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"\u5B50 | 150",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:`.0 | A |
|`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" 2 | \u56DB\u7EBF",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"\u5408\u5E3D\u91CC\u5E03 |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u5E3D\u5B50 | ",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:"11.0 | C",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:` |
| 3 |`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u5E3D\u53E3\u538B\u7EBF",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" | \u5E3D\u5B50 |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" 14.0 |",from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:` C |
| 4 |`,from_variable_selector:["llm","text"]},{event:"message",conversation_id:"10fc41b9-50d5-4323-81e4-ecbb2a087100",message_id:"b733c531-d772-424e-a36c-ff5182ae57d7",created_at:1761197034,task_id:"56ef2056-d679-42ce-9e6f-a6451f726ba8",id:"b733c531-d772-424e-a36c-ff5182ae57d7",answer:" \u5E73\u8F66\u62FC\u8896\u53E3",from_variable_selector:["llm","text"]}];const E={name:"ChatExample",components:{ChatDialog:x,Chat:w},created(){console.log("mockData\u662F\u5426\u5B58\u5728:",!!m),console.log("mockData\u6570\u636E\u7C7B\u578B:",typeof m),Array.isArray(m)&&(console.log("mockData\u6570\u7EC4\u957F\u5EA6:",m.length),console.log("mockData\u524D\u4E24\u6761\u6570\u636E:",m.slice(0,2)))},data(){const n=this.extractStyleInfoData();return console.log("\u521D\u59CB\u5316\u65F6\u4ECEmockData\u63D0\u53D6\u7684\u6B3E\u5F0F\u4FE1\u606F:",n),{messages1:[{id:1,role:"user",content:"\u8BF7\u5C55\u793A mockData \u4E2D\u7684\u6B3E\u5F0F\u4FE1\u606F",timestamp:Date.now()-36e5},{id:2,role:"assistant",content:n,timestamp:Date.now()-35e5,goodCount:1}],dialogVisible:!1,messages2:[{id:1,role:"user",content:"\u8BF7\u5C55\u793A\u6B3E\u5F0F\u4FE1\u606F",timestamp:Date.now()-36e5},{id:2,role:"assistant",content:n,timestamp:Date.now()-35e5,goodCount:1}],customSuggestions:["\u8BF7\u5C55\u793A\u6B3E\u5F0F\u4FE1\u606F","\u663E\u793A\u6B3E\u5F0F\u8BE6\u60C5","\u67E5\u770B\u5DE5\u5E8F\u8868\u683C","\u83B7\u53D6\u6B3E\u5F0F\u6570\u636E"],messages3:[{id:1,role:"user",content:"\u4F60\u597D\uFF0C\u80FD\u5E2E\u6211\u89E3\u91CA\u4E00\u4E0B\u4EC0\u4E48\u662F\u673A\u5668\u5B66\u4E60\u5417\uFF1F",timestamp:Date.now()-36e5},{id:2,role:"assistant",content:`\u673A\u5668\u5B66\u4E60\u662F\u4EBA\u5DE5\u667A\u80FD\u7684\u4E00\u4E2A\u5206\u652F\uFF0C\u5B83\u5141\u8BB8\u8BA1\u7B97\u673A\u7CFB\u7EDF\u901A\u8FC7\u6570\u636E\u548C\u7ECF\u9A8C\u81EA\u52A8\u5B66\u4E60\u548C\u6539\u8FDB\uFF0C\u800C\u4E0D\u9700\u8981\u660E\u786E\u7684\u7F16\u7A0B\u3002

\u673A\u5668\u5B66\u4E60\u7684\u6838\u5FC3\u6982\u5FF5\u5305\u62EC\uFF1A
- \u4ECE\u6570\u636E\u4E2D\u5B66\u4E60\u6A21\u5F0F
- \u8FDB\u884C\u9884\u6D4B\u548C\u51B3\u7B56
- \u968F\u7740\u65B0\u6570\u636E\u7684\u51FA\u73B0\u4E0D\u65AD\u6539\u8FDB

\u5E38\u89C1\u7684\u673A\u5668\u5B66\u4E60\u7C7B\u578B\u5305\u62EC\u76D1\u7763\u5B66\u4E60\u3001\u65E0\u76D1\u7763\u5B66\u4E60\u548C\u5F3A\u5316\u5B66\u4E60\u3002`,timestamp:Date.now()-35e5,goodCount:5}],messages4:[{id:1,role:"user",content:"\u8BF7\u5C55\u793A\u975E\u7F1D\u5236\u76F8\u5173\u7684\u8868\u683C\u6570\u636E",timestamp:Date.now()-36e5},{id:2,role:"assistant",content:this.extractNonStyleTableData()||this.extractStyleInfoData(),timestamp:Date.now()-35e5,goodCount:0}]}},methods:{extractStyleInfoData(){const n=this.extractNonStyleTableData();if(n)return console.log("\u6210\u529F\u63D0\u53D6\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E"),n;if(console.log("mockData\u7C7B\u578B:",typeof m,"\u662F\u5426\u4E3A\u6570\u7EC4:",Array.isArray(m)),!m||!Array.isArray(m))return console.error("mockData\u7ED3\u6784\u4E0D\u6B63\u786E\uFF0C\u65E0\u6CD5\u63D0\u53D6\u6B3E\u5F0F\u4FE1\u606F"),{title:"\u6B3E\u5F0F\u57FA\u672C\u4FE1\u606F",data:{\u6B3E\u540D:"style-003",\u6B3E\u53F7:"KS-20250619-2",\u79DF\u6237:"1027"},table:{headers:["\u5DE5\u5E8F\u53F7","\u5DE5\u5E8F\u540D\u79F0","\u90E8\u4F4D","\u6807\u51C6\u65F6\u95F4(\u79D2)","\u7B49\u7EA7"],rows:[["1","\u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E","\u5E3D\u5B50","150.0","A"],["2","\u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03","\u5E3D\u5B50","11.0","C"],["3","\u5E3D\u53E3\u538B\u7EBF","\u5E3D\u5B50","14.0","C"],["4","\u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9","\u8896\u53E3","16.0","B"],["5","\u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9","\u8896\u53E3","20.0","B"],["6","\u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9","\u8896\u53E3","21.0","C"],["7","\u56DB\u7EBF\u88C5\u63D2\u80A9\u8896","\u7EC4\u88C5","14.0","D"]]}};console.log("\u5F00\u59CB\u4ECE mockData \u63D0\u53D6\u6B3E\u5F0F\u4FE1\u606F\u6570\u636E");const e=m.filter(s=>s&&s.event==="agent_log"&&s.data&&s.data.data&&(s.data.data.label==="CALL getStyleInfo"||s.data.data.action_name==="getStyleInfo"&&s.data.data.observation));console.log("\u627E\u5230\u7684\u76F8\u5173\u4E8B\u4EF6\u6570\u91CF:",e.length);let t=null;for(const s of e)if(s.data.data.observation)try{let a=s.data.data.observation;a=a.replace(/"images":\s*"<([^"]*)\.png",\n>/g,'"images": "$1.png",'),a=a.replace(/"thumbnail":\s*"<([^"]*)\.png",\n>/g,'"thumbnail": "$1.png",'),console.log("\u9884\u5904\u7406\u540E\u7684\u89C2\u5BDF\u7ED3\u679C:",a.substring(0,200),"...");const d=JSON.parse(a);if(d.style_info){t=d;break}}catch(a){console.error("\u89E3\u6790\u6B3E\u5F0F\u6570\u636E\u65F6\u51FA\u9519:",a);const d=s.data.data.observation,l=Math.max(0,235);console.error("\u51FA\u9519\u4F4D\u7F6E\u4E0A\u4E0B\u6587:",d.substring(Math.max(0,l-20),Math.min(d.length,l+50)))}if(t&&t.style_info){const{style_info:s}=t;return console.log("\u6210\u529F\u63D0\u53D6\u6B3E\u5F0F\u4FE1\u606F:",s.style_name),{title:"\u6B3E\u5F0F\u57FA\u672C\u4FE1\u606F",data:{\u6B3E\u540D:s.style_name||"",\u6B3E\u53F7:s.style_no||"",\u79DF\u6237:"1027"},table:{headers:["\u5DE5\u5E8F\u53F7","\u5DE5\u5E8F\u540D\u79F0","\u90E8\u4F4D","\u6807\u51C6\u65F6\u95F4(\u79D2)","\u7B49\u7EA7"],rows:(Array.isArray(s.processes)?s.processes:[]).map(a=>[(a.process_no||"").toString(),a.process_name||"",a.part_name||"",(a.std_time||"").toString(),a.level||""])}}}return console.log("\u672A\u627E\u5230\u6B3E\u5F0F\u6570\u636E\uFF0C\u8FD4\u56DE\u5907\u7528\u6570\u636E"),{title:"\u6B3E\u5F0F\u57FA\u672C\u4FE1\u606F",data:{\u6B3E\u540D:"style-003",\u6B3E\u53F7:"KS-20250619-2",\u79DF\u6237:"1027"},table:{headers:["\u5DE5\u5E8F\u53F7","\u5DE5\u5E8F\u540D\u79F0","\u90E8\u4F4D","\u6807\u51C6\u65F6\u95F4(\u79D2)","\u7B49\u7EA7"],rows:[["1","\u6C14\u773C\u8F66\u5E3D\u53E3\u5145\u6D1E","\u5E3D\u5B50","150.0","A"],["2","\u56DB\u7EBF\u5408\u5E3D\u91CC\u5E03","\u5E3D\u5B50","11.0","C"],["3","\u5E3D\u53E3\u538B\u7EBF","\u5E3D\u5B50","14.0","C"],["4","\u5E73\u8F66\u62FC\u8896\u53E3\u87BA\u7EB9","\u8896\u53E3","16.0","B"],["5","\u624B\u5DE5\u7FFB\u8896\u53E3\u87BA\u7EB9","\u8896\u53E3","20.0","B"],["6","\u5E73\u8F66\u56FA\u5B9A\u8896\u53E3\u87BA\u7EB9","\u8896\u53E3","21.0","C"],["7","\u56DB\u7EBF\u88C5\u63D2\u80A9\u8896","\u7EC4\u88C5","14.0","D"]]}}},handleSend1(n){const e=n.message;console.log("\u7528\u6237\u53D1\u9001\u6D88\u606F\u5230\u793A\u4F8B1:",e);const t={id:Date.now(),role:"user",content:e.content,timestamp:Date.now()};this.messages1.push(t),console.log("\u7528\u6237\u6D88\u606F\u5DF2\u6DFB\u52A0\u5230\u804A\u5929\u8BB0\u5F55"),setTimeout(()=>{const s=this.extractStyleInfoData();console.log("\u63D0\u53D6\u7684\u6B3E\u5F0F\u4FE1\u606F\u6570\u636E:",s);const a={id:Date.now()+1,role:"assistant",content:s,timestamp:Date.now(),goodCount:0};this.messages1.push(a),console.log("AI\u56DE\u590D\u7684\u6B3E\u5F0F\u4FE1\u606F\u5DF2\u6DFB\u52A0\u5230\u804A\u5929\u8BB0\u5F55")},800)},handleSend2(n){const e=n.message;console.log("\u7528\u6237\u53D1\u9001\u6D88\u606F\u5230\u793A\u4F8B2:",e);const t={id:Date.now(),role:"user",content:e.content,timestamp:Date.now()};this.messages2.push(t),console.log("\u7528\u6237\u6D88\u606F\u5DF2\u6DFB\u52A0\u5230\u804A\u5929\u8BB0\u5F55"),setTimeout(()=>{const s=this.extractStyleInfoData();console.log("\u63D0\u53D6\u7684\u6B3E\u5F0F\u4FE1\u606F\u6570\u636E:",s);const a={id:Date.now()+1,role:"assistant",content:s,timestamp:Date.now(),goodCount:0};this.messages2.push(a),console.log("AI\u56DE\u590D\u7684\u6B3E\u5F0F\u4FE1\u606F\u5DF2\u6DFB\u52A0\u5230\u804A\u5929\u8BB0\u5F55")},800)},handleSend3(n){const e=n.message;setTimeout(()=>{const t={id:Date.now(),role:"assistant",content:`\u4F60\u95EE\u4E86\uFF1A${e.content}

\u8FD9\u91CC\u662F\u4E00\u4E9B\u76F8\u5173\u4FE1\u606F\u548C\u5EFA\u8BAE\u3002\u4F60\u53EF\u4EE5\u7EE7\u7EED\u63D0\u95EE\uFF0C\u6211\u4F1A\u5C3D\u529B\u5E2E\u52A9\u4F60\u3002`,timestamp:Date.now()};this.messages3.push(t)},800)},extractNonStyleTableData(){try{const n=m.filter(e=>e&&e.event==="message"&&e.data&&e.data.answer&&typeof e.data.answer=="string"&&e.data.answer.includes("|"));console.log("\u627E\u5230\u7684\u5305\u542B\u8868\u683C\u7684\u6D88\u606F\u6570\u91CF:",n.length);for(const e of n){const t=e.data.answer;if(t.includes("\u4EA7\u54C1\u7F16\u53F7")&&t.includes("\u5E93\u5B58\u6570\u91CF")){const s=this.parseMarkdownTable(t);if(s)return{title:"\u4EA7\u54C1\u5E93\u5B58\u4FE1\u606F",data:{\u6570\u636E\u6765\u6E90:"\u6A21\u62DF\u6570\u636E - \u4EA7\u54C1\u5E93\u5B58\u4FE1\u606F"},table:s}}if(t.includes("\u8BBE\u5907\u7F16\u53F7")&&t.includes("\u7EF4\u62A4\u65E5\u671F")){const s=this.parseMarkdownTable(t);if(s)return{title:"\u8BBE\u5907\u7EF4\u62A4\u8BB0\u5F55",data:{\u6570\u636E\u6765\u6E90:"\u6A21\u62DF\u6570\u636E - \u8BBE\u5907\u7EF4\u62A4\u8BB0\u5F55"},table:s}}}}catch(n){console.error("\u63D0\u53D6\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E\u65F6\u51FA\u9519:",n)}return null},parseMarkdownTable(n){try{const e=n.split(`
`).filter(a=>a.trim().includes("|"));if(e.length<3)return null;const t=e[0].split("|").map(a=>a.trim()).filter(a=>a!==""),s=[];for(let a=2;a<e.length;a++){const d=e[a].split("|").map(l=>l.trim()).filter(l=>l!=="");d.length===t.length&&s.push(d)}return{headers:t,rows:s}}catch(e){return console.error("\u89E3\u6790Markdown\u8868\u683C\u65F6\u51FA\u9519:",e),null}},testNonStyleData(){console.log("\u6D4B\u8BD5\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E...");const n=this.extractNonStyleTableData();if(console.log("\u4ECEmockData\u63D0\u53D6\u7684\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E:",n),!n)return console.log("\u672A\u627E\u5230\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E\uFF0C\u4F7F\u7528\u6B3E\u5F0F\u4FE1\u606F\u4F5C\u4E3A\u5907\u7528"),this.testMockData();const e=document.createElement("div");e.style.position="fixed",e.style.top="50%",e.style.left="50%",e.style.transform="translate(-50%, -50%)",e.style.width="80%",e.style.maxWidth="800px",e.style.height="80%",e.style.maxHeight="600px",e.style.backgroundColor="white",e.style.borderRadius="8px",e.style.boxShadow="0 4px 20px rgba(0,0,0,0.15)",e.style.padding="20px",e.style.overflow="auto",e.style.zIndex="9999";const t=document.createElement("button");t.innerText="\u5173\u95ED",t.style.position="absolute",t.style.top="10px",t.style.right="10px",t.style.padding="5px 15px",t.style.backgroundColor="#409eff",t.style.color="white",t.style.border="none",t.style.borderRadius="4px",t.style.cursor="pointer",t.onclick=()=>document.body.removeChild(e),e.appendChild(t);const s=document.createElement("h3");if(s.innerText=n.title||"\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E",s.style.marginBottom="12px",s.style.fontSize="18px",e.appendChild(s),n.data){const a=document.createElement("div");a.style.marginBottom="16px";const d=document.createElement("h4");d.innerText="\u57FA\u672C\u4FE1\u606F",d.style.marginBottom="8px",d.style.fontSize="16px",a.appendChild(d);const l=document.createElement("table");l.style.width="100%",l.style.borderCollapse="collapse";for(const[f,i]of Object.entries(n.data)){const r=document.createElement("tr");r.style.borderBottom="1px solid #eee";const c=document.createElement("td");c.innerText=f+":",c.style.fontWeight="bold",c.style.padding="4px 8px",c.style.lineHeight="1.4";const o=document.createElement("td");o.innerText=i,o.style.padding="4px 8px",o.style.lineHeight="1.4",r.appendChild(c),r.appendChild(o),l.appendChild(r)}a.appendChild(l),e.appendChild(a)}if(n.table&&n.table.headers&&n.table.rows){const a=document.createElement("div"),d=document.createElement("h4");d.innerText=n.title+"\u8868",d.style.marginBottom="8px",d.style.fontSize="16px",a.appendChild(d);const l=document.createElement("table");l.style.width="100%",l.style.borderCollapse="collapse";const f=document.createElement("thead"),i=document.createElement("tr");n.table.headers.forEach(c=>{const o=document.createElement("th");o.innerText=c,o.style.border="1px solid #ddd",o.style.padding="6px 8px",o.style.backgroundColor="#f5f7fa",o.style.lineHeight="1.4",i.appendChild(o)}),f.appendChild(i),l.appendChild(f);const r=document.createElement("tbody");n.table.rows.forEach((c,o)=>{const p=document.createElement("tr");p.style.backgroundColor=o%2==0?"#fff":"#fafafa",c.forEach(y=>{const b=document.createElement("td");b.innerText=y,b.style.border="1px solid #ddd",b.style.padding="6px 8px",b.style.lineHeight="1.4",p.appendChild(b)}),r.appendChild(p)}),l.appendChild(r),a.appendChild(l),e.appendChild(a)}document.body.appendChild(e)},testMockData(){console.log("\u6D4B\u8BD5mockData\u5185\u5BB9..."),console.log("mockData:",m);const n=this.extractStyleInfoData();if(console.log("\u4ECEmockData\u63D0\u53D6\u7684\u6B3E\u5F0F\u4FE1\u606F:",n),n){const e=document.createElement("div");e.style.position="fixed",e.style.top="50%",e.style.left="50%",e.style.transform="translate(-50%, -50%)",e.style.width="80%",e.style.maxWidth="800px",e.style.height="80%",e.style.maxHeight="600px",e.style.backgroundColor="white",e.style.borderRadius="8px",e.style.boxShadow="0 4px 20px rgba(0,0,0,0.15)",e.style.padding="20px",e.style.overflow="auto",e.style.zIndex="9999";const t=document.createElement("button");t.innerText="\u5173\u95ED",t.style.position="absolute",t.style.top="10px",t.style.right="10px",t.style.padding="5px 15px",t.style.backgroundColor="#409eff",t.style.color="white",t.style.border="none",t.style.borderRadius="4px",t.style.cursor="pointer",t.onclick=()=>document.body.removeChild(e),e.appendChild(t);const s=document.createElement("h3");if(s.innerText=n.title||"\u6B3E\u5F0F\u4FE1\u606F",s.style.marginBottom="12px",s.style.fontSize="18px",e.appendChild(s),n.data){const a=document.createElement("div");a.style.marginBottom="16px";const d=document.createElement("h4");d.innerText="\u57FA\u672C\u4FE1\u606F",d.style.marginBottom="8px",d.style.fontSize="16px",a.appendChild(d);const l=document.createElement("table");l.style.width="100%",l.style.borderCollapse="collapse";for(const[f,i]of Object.entries(n.data)){const r=document.createElement("tr");r.style.borderBottom="1px solid #eee";const c=document.createElement("td");c.innerText=f+":",c.style.fontWeight="bold",c.style.padding="4px 8px",c.style.lineHeight="1.4";const o=document.createElement("td");o.innerText=i,o.style.padding="4px 8px",o.style.lineHeight="1.4",r.appendChild(c),r.appendChild(o),l.appendChild(r)}a.appendChild(l),e.appendChild(a)}if(n.table&&n.table.headers&&n.table.rows){const a=document.createElement("div"),d=document.createElement("h4");d.innerText="\u5DE5\u5E8F\u5217\u8868",d.style.marginBottom="8px",d.style.fontSize="16px",a.appendChild(d);const l=document.createElement("table");l.style.width="100%",l.style.borderCollapse="collapse";const f=document.createElement("thead"),i=document.createElement("tr");n.table.headers.forEach(c=>{const o=document.createElement("th");o.innerText=c,o.style.border="1px solid #ddd",o.style.padding="6px 8px",o.style.backgroundColor="#f5f7fa",o.style.lineHeight="1.4",i.appendChild(o)}),f.appendChild(i),l.appendChild(f);const r=document.createElement("tbody");n.table.rows.forEach((c,o)=>{const p=document.createElement("tr");p.style.backgroundColor=o%2==0?"#fff":"#fafafa",c.forEach(y=>{const b=document.createElement("td");b.innerText=y,b.style.border="1px solid #ddd",b.style.padding="6px 8px",b.style.lineHeight="1.4",p.appendChild(b)}),r.appendChild(p)}),l.appendChild(r),a.appendChild(l),e.appendChild(a)}document.body.appendChild(e)}},handleSend4(n){const e=n.message;console.log("\u7528\u6237\u53D1\u9001\u6D88\u606F\u5230\u793A\u4F8B4:",e);const t={id:Date.now(),role:"user",content:e.content,timestamp:Date.now()};this.messages4.push(t),console.log("\u7528\u6237\u6D88\u606F\u5DF2\u6DFB\u52A0\u5230\u804A\u5929\u8BB0\u5F55"),setTimeout(()=>{const a=this.extractNonStyleTableData()||this.extractStyleInfoData();console.log("\u5C55\u793A\u7684\u8868\u683C\u6570\u636E:",a);const d={id:Date.now()+1,role:"assistant",content:a,timestamp:Date.now(),goodCount:0};this.messages4.push(d),console.log("AI\u56DE\u590D\u7684\u8868\u683C\u6570\u636E\u5DF2\u6DFB\u52A0\u5230\u804A\u5929\u8BB0\u5F55")},800)},handleAskSuggestion(n){const e={id:Date.now(),role:"user",content:n,timestamp:Date.now()};this.messages2.push(e),setTimeout(()=>{const t=this.extractStyleInfoData(),s={id:Date.now()+1,role:"assistant",content:t,timestamp:Date.now(),goodCount:0};this.messages2.push(s)},800)}}},T={class:"chat-example-wrapper"},B={class:"example-section"},A={class:"example-section"},I=["onClick"],M={class:"example-section"},N={class:"embedded-chat"},R={class:"example-section"};function j(n,e,t,s,a,d){const l=v("Chat"),f=v("ChatDialog");return C(),D("div",T,[e[10]||(e[10]=_("h2",{class:"example-title"},"\u7B80\u5316\u7248\u804A\u5929\u7EC4\u4EF6\u793A\u4F8B",-1)),_("div",B,[e[4]||(e[4]=_("h3",{class:"section-title"}," \u793A\u4F8B1\uFF1A\u6B3E\u5F0F\u4FE1\u606F\u5C55\u793A\uFF08\u70B9\u51FB\u6309\u94AE\u67E5\u770B mockData\uFF09 ",-1)),e[5]||(e[5]=_("div",{class:"example-note"},[_("strong",null,"\u8BF4\u660E\uFF1A"),h("\u6B64\u793A\u4F8B\u76F4\u63A5\u5C55\u793A\u4ECE mockData \u63D0\u53D6\u7684\u6B3E\u5F0F\u4FE1\u606F\u6570\u636E\uFF0C\u5305\u542B\u6B3E\u5F0F\u57FA\u672C\u4FE1\u606F\u548C\u5DE5\u5E8F\u8868\u683C\u3002 ")],-1)),_("button",{class:"test-btn",onClick:e[0]||(e[0]=(...i)=>d.testMockData&&d.testMockData(...i))}," \u70B9\u51FB\u76F4\u63A5\u67E5\u770B mockData \u5185\u5BB9 "),u(f,{title:"\u6B3E\u5F0F\u4FE1\u606F\u67E5\u8BE2\u6F14\u793A",width:"700px",height:"600px","trigger-text":"\u70B9\u51FB\u67E5\u770B\u6B3E\u5F0F\u4FE1\u606F"},{default:g(()=>[u(l,{messages:a.messages1,onSend:d.handleSend1},null,8,["messages","onSend"])]),_:1})]),_("div",A,[e[6]||(e[6]=_("h3",{class:"section-title"},"\u793A\u4F8B2\uFF1A\u81EA\u5B9A\u4E49\u89E6\u53D1\u6309\u94AE + \u53D7\u63A7\u6A21\u5F0F",-1)),u(f,{title:"\u81EA\u5B9A\u4E49\u804A\u5929\u5BF9\u8BDD\u6846",width:"700px",height:"600px",visible:a.dialogVisible,"onUpdate:visible":e[2]||(e[2]=i=>a.dialogVisible=i),"custom-trigger":!0},{trigger:g(({open:i,close:r})=>[_("button",{class:"custom-trigger-btn",onClick:c=>a.dialogVisible?r():i()},S(a.dialogVisible?"\u5173\u95ED\u5BF9\u8BDD\u6846":"\u6253\u5F00\u81EA\u5B9A\u4E49\u5BF9\u8BDD\u6846"),9,I)]),default:g(()=>[u(l,{messages:a.messages2,"show-try-to-ask":!0,suggestions:a.customSuggestions,onSend:d.handleSend2,onAsk:d.handleAskSuggestion,onClose:e[1]||(e[1]=i=>a.dialogVisible=!1)},null,8,["messages","suggestions","onSend","onAsk"])]),_:1},8,["visible"])]),_("div",M,[e[7]||(e[7]=_("h3",{class:"section-title"},"\u793A\u4F8B3\uFF1A\u76F4\u63A5\u5D4C\u5165\uFF08\u975E\u5F39\u7A97\u6A21\u5F0F\uFF09",-1)),_("div",N,[u(l,{messages:a.messages3,"show-try-to-ask":!1,onSend:d.handleSend3},null,8,["messages","onSend"])])]),_("div",R,[e[8]||(e[8]=_("h3",{class:"section-title"},"\u793A\u4F8B4\uFF1A\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E\u5C55\u793A",-1)),e[9]||(e[9]=_("div",{class:"example-note"},[_("strong",null,"\u8BF4\u660E\uFF1A"),h("\u6B64\u793A\u4F8B\u5C55\u793A\u4ECE mockData \u63D0\u53D6\u7684\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E\uFF0C\u5305\u62EC\u4EA7\u54C1\u5E93\u5B58\u4FE1\u606F\u548C\u8BBE\u5907\u7EF4\u62A4\u8BB0\u5F55\u3002 ")],-1)),_("button",{class:"test-btn",onClick:e[3]||(e[3]=(...i)=>d.testNonStyleData&&d.testNonStyleData(...i))}," \u70B9\u51FB\u67E5\u770B\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E "),u(f,{title:"\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E\u6F14\u793A",width:"700px",height:"600px","trigger-text":"\u70B9\u51FB\u67E5\u770B\u975E\u7F1D\u5236\u76F8\u5173\u8868\u683C\u6570\u636E"},{default:g(()=>[u(l,{messages:a.messages4,onSend:d.handleSend4},null,8,["messages","onSend"])]),_:1})])])}var P=k(E,[["render",j]]);export{P as default};
