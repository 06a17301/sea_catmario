`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/07/29 22:04:53
// Design Name: 
// Module Name: key2move
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module key2move(
    input clk,//clk_system
    input rst,
     input [1:0]game_status,////这个只要传输给HDMI_display就行,no
    input key_left,
    input key_right,
    input key_jump,
    
    input [11:0]monster_x,
    input [11:0]monster_y,
    input monster_en0,
    
    output reg [11:0]cat_x=13*32,//=12'd90,是否可以赋初值？？？？？？？？？？？？？？？？？？？
    output reg [11:0]cat_y=21*32,//=12'd840,
    output   cat_win,//////////////需要reg吗????????????????????????????????????????
    output   cat_die,
    output  reg hit_unknown1,
    output  reg hit_unknown2,
    output  reg hit_unknown3
    );
    
    ////////////////////////////////////////////////////////////////////////按键检测/////////////////////////////////
    reg left_en;
    reg right_en;
    reg jump_en;
       
    reg [1:0]jump_i=0;
    reg [1:0]left_i=0;
    reg [1:0]right_i=0;

        always@(posedge clk or negedge rst) 
        begin
        if(!rst) begin
 //           clk_cnt <= 0;
            left_en <= 0;
            right_en <= 0;
            jump_en<=0;                            
        end 
        else begin

                if(left_i==2'b01)//if(left_i==2'b10)
                    left_en <= 1;
    //            if(right_key_last == 0 && key_right == 1)
                else if(left_i==2'b10)//left_i==2'b01
                    left_en <= 0;
                else if(right_i==2'b01)//(right_i==2'b10)
                    right_en <= 1;
                    else if(right_i==2'b10)//(right_i==2'b01)
                    right_en <=0;
     //           if(jump_key_last == 0 && key_jump == 1)
                else  if(jump_i==2'b01)//jump_i==2'b10)
                    jump_en <= 1;
                    else  if(jump_i==2'b10)//if(jump_i==2'b01)
                    jump_en <= 0;
            end
      end                           
  
    always@(posedge clk or negedge rst)///////////检测key的上升沿
        begin
            if(!rst)
            jump_i<=2'b00;
            else
            jump_i<={jump_i[0],key_jump};
        end    
        always@(posedge clk or negedge rst)///////////检测key的上升沿
        begin
            if(!rst)
            left_i<=2'b00;
            else
            left_i<={left_i[0],key_left};
        end  
            always@(posedge clk or negedge rst)///////////检测key的上升沿
        begin
            if(!rst)
            right_i<=2'b00;
            else
            right_i<={right_i[0],key_right};
        end
  
 reg [11:0]cat_y0=32*21;/////////////////////////////////////记录跳起时的纵坐标/////////////////////
// reg [1:0]jump_ch=0;
// always@(posedge clk or negedge rst)///////////检测key的上升沿
//        begin
//            if(!rst)
//            jump_ch<=2'b00;
//            else
//            jump_ch<={jump_ch[0],jump_en};
//        end
  reg down=0;
 always@(posedge clk)
    begin
    if(jump_i==2'b01)// (jump_i==2'b10)
    cat_y0<=cat_y;
//    else if(jump_i==2'b01)
//    down<=0;
    //cat_y0<=cat_y0;//////////////////////////??????????????????????????/
    end
    
  
  ////////////////////////////////////////////对地图分块标记/////////////////////
   reg[2:0] mem[0:644]; 
   initial
begin
mem[0]=3'b010;   mem[1]=3'b100;   mem[2]=3'b100;   mem[3]=3'b100;   mem[4]=3'b100;   mem[5]=3'b100;   mem[6]=3'b100; 
  mem[7]=3'b100;   mem[8]=3'b100;   mem[9]=3'b100;   mem[10]=3'b100;  mem[11]=3'b100;  mem[12]=3'b100;  mem[13]=3'b100; 
   mem[14]=3'b100;  mem[15]=3'b100;  mem[16]=3'b100;  mem[17]=3'b100;  mem[18]=3'b100;  mem[19]=3'b100;  mem[20]=3'b100;  
   mem[21]=3'b100;  mem[22]=3'b100;  mem[23]=3'b100;  mem[24]=3'b100;  mem[25]=3'b100;  mem[26]=3'b100;  mem[27]=3'b100;  
   mem[28]=3'b100;  mem[29]=3'b100;  mem[30]=3'b100;  mem[31]=3'b100;  mem[32]=3'b100;  mem[33]=3'b100;  mem[34]=3'b100;  
   mem[35]=3'b100;  mem[36]=3'b100;  mem[37]=3'b100;  mem[38]=3'b100;  mem[39]=3'b100;  mem[40]=3'b100;  mem[41]=3'b100;  
   mem[42]=3'b100;  
mem[43]=3'b010;  mem[44]=3'b000;  mem[45]=3'b000;  mem[46]=3'b000;  mem[47]=3'b000;  mem[48]=3'b000;  mem[49]=3'b000;  
mem[50]=3'b000;  mem[51]=3'b000;  mem[52]=3'b000;  mem[53]=3'b000;  mem[54]=3'b000;  mem[55]=3'b000;  mem[56]=3'b000;  
mem[57]=3'b000;  mem[58]=3'b000;  mem[59]=3'b000;  mem[60]=3'b000;  mem[61]=3'b000;  mem[62]=3'b000;  mem[63]=3'b000;  
mem[64]=3'b000;  mem[65]=3'b000;  mem[66]=3'b000;  mem[67]=3'b000;  mem[68]=3'b000;  mem[69]=3'b000;  mem[70]=3'b000;  
mem[71]=3'b000;  mem[72]=3'b000;  mem[73]=3'b000;  mem[74]=3'b000;  mem[75]=3'b000;  mem[76]=3'b000;  mem[77]=3'b000;  
mem[78]=3'b000;  mem[79]=3'b000;  mem[80]=3'b000;  mem[81]=3'b000;  mem[82]=3'b000;  mem[83]=3'b000;  mem[84]=3'b000;  
mem[85]=3'b011;  
mem[86]=3'b010;  mem[87]=3'b000;  mem[88]=3'b000;  mem[89]=3'b000;  mem[90]=3'b000;  mem[91]=3'b000;  mem[92]=3'b000;  
mem[93]=3'b000;  mem[94]=3'b000;  mem[95]=3'b000;  mem[96]=3'b000;  mem[97]=3'b000;  mem[98]=3'b000;  mem[99]=3'b000;  
mem[100]=3'b000; mem[101]=3'b000; mem[102]=3'b000; mem[103]=3'b000; mem[104]=3'b000; mem[105]=3'b000; mem[106]=3'b000; 
mem[107]=3'b000; mem[108]=3'b000; mem[109]=3'b000; mem[110]=3'b000; mem[111]=3'b000; mem[112]=3'b000; mem[113]=3'b000; 
mem[114]=3'b000; mem[115]=3'b000; mem[116]=3'b000; mem[117]=3'b000; mem[118]=3'b000; mem[119]=3'b000; mem[120]=3'b000; 
mem[121]=3'b000; mem[122]=3'b000; mem[123]=3'b000; mem[124]=3'b000; mem[125]=3'b000; mem[126]=3'b000; mem[127]=3'b000; 
mem[128]=3'b011; 
mem[129]=3'b010; mem[130]=3'b000; mem[131]=3'b000; mem[132]=3'b000; mem[133]=3'b000; mem[134]=3'b000; mem[135]=3'b000; 
mem[136]=3'b000; mem[137]=3'b000; mem[138]=3'b000; mem[139]=3'b000; mem[140]=3'b000; mem[141]=3'b000; mem[142]=3'b000; 
mem[143]=3'b000; mem[144]=3'b000; mem[145]=3'b000; mem[146]=3'b000; mem[147]=3'b000; mem[148]=3'b000; mem[149]=3'b000; 
mem[150]=3'b000; mem[151]=3'b000; mem[152]=3'b000; mem[153]=3'b000; mem[154]=3'b000; mem[155]=3'b000; mem[156]=3'b000; 
mem[157]=3'b000; mem[158]=3'b000; mem[159]=3'b000; mem[160]=3'b000; mem[161]=3'b000; mem[162]=3'b000; mem[163]=3'b000; 
mem[164]=3'b000; mem[165]=3'b000; mem[166]=3'b000; mem[167]=3'b000; mem[168]=3'b000; mem[169]=3'b000; mem[170]=3'b000; 
mem[171]=3'b011; 
mem[172]=3'b010; mem[173]=3'b000; mem[174]=3'b000; mem[175]=3'b000; mem[176]=3'b000; mem[177]=3'b000; mem[178]=3'b000; mem[179]=3'b000; mem[180]=3'b000; mem[181]=3'b000; mem[182]=3'b000; mem[183]=3'b000; mem[184]=3'b000; mem[185]=3'b000; mem[186]=3'b000; mem[187]=3'b000; mem[188]=3'b000; mem[189]=3'b000; mem[190]=3'b000; mem[191]=3'b000; mem[192]=3'b000; mem[193]=3'b000; mem[194]=3'b000; mem[195]=3'b000; mem[196]=3'b000; mem[197]=3'b000; mem[198]=3'b000; mem[199]=3'b000; mem[200]=3'b000; mem[201]=3'b000; mem[202]=3'b000; mem[203]=3'b000; mem[204]=3'b000; mem[205]=3'b000; mem[206]=3'b000; mem[207]=3'b000; mem[208]=3'b000; mem[209]=3'b000; mem[210]=3'b000; mem[211]=3'b000; mem[212]=3'b000; mem[213]=3'b000; mem[214]=3'b011; 
mem[215]=3'b010; mem[216]=3'b000; mem[217]=3'b000; mem[218]=3'b000; mem[219]=3'b000; mem[220]=3'b000; mem[221]=3'b000; mem[222]=3'b000; mem[223]=3'b000; mem[224]=3'b000; mem[225]=3'b000; mem[226]=3'b000; mem[227]=3'b000; mem[228]=3'b000; mem[229]=3'b000; mem[230]=3'b000; mem[231]=3'b000; mem[232]=3'b000; mem[233]=3'b000; mem[234]=3'b000; mem[235]=3'b000; mem[236]=3'b000; mem[237]=3'b000; mem[238]=3'b000; mem[239]=3'b000; mem[240]=3'b000; mem[241]=3'b000; mem[242]=3'b000; mem[243]=3'b000; mem[244]=3'b000; mem[245]=3'b000; mem[246]=3'b000; mem[247]=3'b000; mem[248]=3'b000; mem[249]=3'b000; mem[250]=3'b000; mem[251]=3'b000; mem[252]=3'b000; mem[253]=3'b000; mem[254]=3'b000; mem[255]=3'b000; mem[256]=3'b000; mem[257]=3'b011; 
mem[258]=3'b010; mem[259]=3'b000; mem[260]=3'b000; mem[261]=3'b000; mem[262]=3'b000; mem[263]=3'b000; mem[264]=3'b000; mem[265]=3'b000; mem[266]=3'b000; mem[267]=3'b000; mem[268]=3'b000; mem[269]=3'b000; mem[270]=3'b000; mem[271]=3'b000; mem[272]=3'b000; mem[273]=3'b000; mem[274]=3'b000; mem[275]=3'b000; mem[276]=3'b000; mem[277]=3'b000; mem[278]=3'b000; mem[279]=3'b000; mem[280]=3'b000; mem[281]=3'b000; mem[282]=3'b000; mem[283]=3'b000; mem[284]=3'b000; mem[285]=3'b000; mem[286]=3'b000; mem[287]=3'b000; mem[288]=3'b000; mem[289]=3'b000; mem[290]=3'b000; mem[291]=3'b000; mem[292]=3'b000; mem[293]=3'b000; mem[294]=3'b000; mem[295]=3'b000; mem[296]=3'b000; mem[297]=3'b000; mem[298]=3'b000; mem[299]=3'b000; mem[300]=3'b011; 

///////////8
mem[301]=3'b010; mem[302]=3'b000; mem[303]=3'b000; mem[304]=3'b000; mem[305]=3'b001; mem[306]=3'b001; mem[307]=3'b000; 
mem[308]=3'b000; mem[309]=3'b001; mem[310]=3'b001; mem[311]=3'b001; mem[312]=3'b001; mem[313]=3'b001; mem[314]=3'b001; 
mem[315]=3'b000; mem[316]=3'b000; mem[317]=3'b000; mem[318]=3'b000; mem[319]=3'b000; mem[320]=3'b000; mem[321]=3'b000; 
mem[322]=3'b000; mem[323]=3'b000; mem[324]=3'b000; mem[325]=3'b000; mem[326]=3'b000; mem[327]=3'b000; mem[328]=3'b000; 
mem[329]=3'b000; mem[330]=3'b000; mem[331]=3'b000; mem[332]=3'b000; mem[333]=3'b000; mem[334]=3'b000; mem[335]=3'b000; 
mem[336]=3'b000; mem[337]=3'b000; mem[338]=3'b000; mem[339]=3'b000; mem[340]=3'b000; mem[341]=3'b000; mem[342]=3'b000; 
mem[343]=3'b011; 
////////////9
mem[344]=3'b010; mem[345]=3'b000; mem[346]=3'b000; mem[347]=3'b000; mem[348]=3'b011; mem[349]=3'b000; mem[350]=3'b010; 
mem[351]=3'b000; mem[352]=3'b011; mem[353]=3'b000; mem[354]=3'b000; mem[355]=3'b000; mem[356]=3'b000; mem[357]=3'b000; 
mem[358]=3'b010; mem[359]=3'b000; mem[360]=3'b001; mem[361]=3'b001; mem[362]=3'b001; mem[363]=3'b000; mem[364]=3'b000; 
mem[365]=3'b000; mem[366]=3'b000; mem[367]=3'b000; mem[368]=3'b001; mem[369]=3'b001; mem[370]=3'b000; mem[371]=3'b000; //001</001
mem[372]=3'b001; mem[373]=3'b001; mem[374]=3'b000; mem[375]=3'b000; mem[376]=3'b000; mem[377]=3'b000; mem[378]=3'b000; 
mem[379]=3'b001; mem[380]=3'b001; mem[381]=3'b001; mem[382]=3'b000; mem[383]=3'b000; mem[384]=3'b000; mem[385]=3'b000; 
mem[386]=3'b011; 

//////////////////////10
mem[387]=3'b010; mem[388]=3'b000; mem[389]=3'b000; mem[390]=3'b000; mem[391]=3'b011; mem[392]=3'b001; mem[393]=3'b010; 
mem[394]=3'b000; mem[395]=3'b011; mem[396]=3'b001; mem[397]=3'b001; mem[398]=3'b001; mem[399]=3'b001; mem[400]=3'b001; 
mem[401]=3'b010; mem[402]=3'b000; mem[403]=3'b000; mem[404]=3'b011; mem[405]=3'b001; mem[406]=3'b010; mem[407]=3'b000; //404/000/405/000
mem[408]=3'b000; mem[409]=3'b000; mem[410]=3'b001; mem[411]=3'b001; mem[412]=3'b000; mem[413]=3'b010; mem[414]=3'b000; //001</001
mem[415]=3'b011; mem[416]=3'b001; mem[417]=3'b001; mem[418]=3'b000; mem[419]=3'b000; mem[420]=3'b000; mem[421]=3'b000; 
mem[422]=3'b011; mem[423]=3'b000; mem[424]=3'b000; mem[425]=3'b010; mem[426]=3'b000; mem[427]=3'b000; mem[428]=3'b000; 
mem[429]=3'b011; 

////////////11
mem[430]=3'b010; mem[431]=3'b000; mem[432]=3'b000; mem[433]=3'b000; mem[434]=3'b100; mem[435]=3'b101; mem[436]=3'b000; 
mem[437]=3'b000; mem[438]=3'b100; mem[439]=3'b100; mem[440]=3'b101; mem[441]=3'b100; mem[442]=3'b101; mem[443]=3'b100; 
mem[444]=3'b000; mem[445]=3'b000; mem[446]=3'b011; mem[447]=3'b001; mem[448]=3'b001; mem[449]=3'b010; mem[450]=3'b000; 
mem[451]=3'b000; mem[452]=3'b000; mem[453]=3'b011; mem[454]=3'b000; mem[455]=3'b001; mem[456]=3'b010; mem[457]=3'b000; 
mem[458]=3'b011; mem[459]=3'b001; mem[460]=3'b000; mem[461]=3'b010; mem[462]=3'b000; mem[463]=3'b000; mem[464]=3'b000; 
mem[465]=3'b011; mem[466]=3'b001; mem[467]=3'b001; mem[468]=3'b010; mem[469]=3'b000; mem[470]=3'b000; mem[471]=3'b000; 
mem[472]=3'b011; 

///////////////12
mem[473]=3'b010; mem[474]=3'b001; mem[475]=3'b001; mem[476]=3'b001; mem[477]=3'b001; mem[478]=3'b001; mem[479]=3'b001; 
mem[480]=3'b001; mem[481]=3'b001; mem[482]=3'b001; mem[483]=3'b001; mem[484]=3'b001; mem[485]=3'b001; mem[486]=3'b001; 
mem[487]=3'b001; mem[488]=3'b001; mem[489]=3'b011; mem[490]=3'b001; mem[491]=3'b001; mem[492]=3'b010; mem[493]=3'b001; 
mem[494]=3'b001; mem[495]=3'b001; mem[496]=3'b011; mem[497]=3'b001; mem[498]=3'b001; mem[499]=3'b010; mem[500]=3'b000; 
mem[501]=3'b011; mem[502]=3'b001; mem[503]=3'b001; mem[504]=3'b010; mem[505]=3'b001; mem[506]=3'b001; mem[507]=3'b001; 
mem[508]=3'b011; mem[509]=3'b001; mem[510]=3'b001; mem[511]=3'b010; mem[512]=3'b001; mem[513]=3'b001; mem[514]=3'b001; 
mem[515]=3'b001; 
mem[516]=3'b010; mem[517]=3'b000; mem[518]=3'b000; mem[519]=3'b000; mem[520]=3'b000; mem[521]=3'b000; mem[522]=3'b000; mem[523]=3'b000; mem[524]=3'b000; mem[525]=3'b000; mem[526]=3'b000; mem[527]=3'b000; mem[528]=3'b000; mem[529]=3'b000; mem[530]=3'b000; mem[531]=3'b000; mem[532]=3'b011; mem[533]=3'b001; mem[534]=3'b001; mem[535]=3'b010; mem[536]=3'b000; mem[537]=3'b000; mem[538]=3'b000; mem[539]=3'b011; mem[540]=3'b001; mem[541]=3'b001; mem[542]=3'b010; mem[543]=3'b000; mem[544]=3'b011; mem[545]=3'b001; mem[546]=3'b001; mem[547]=3'b000; mem[548]=3'b000; mem[549]=3'b000; mem[550]=3'b000; mem[551]=3'b011; mem[552]=3'b001; mem[553]=3'b001; mem[554]=3'b010; mem[555]=3'b000; mem[556]=3'b000; mem[557]=3'b000; mem[558]=3'b001; 
mem[559]=3'b001; mem[560]=3'b001; mem[561]=3'b001; mem[562]=3'b001; mem[563]=3'b001; mem[564]=3'b001; mem[565]=3'b001; mem[566]=3'b001; mem[567]=3'b001; mem[568]=3'b001; mem[569]=3'b001; mem[570]=3'b001; mem[571]=3'b001; mem[572]=3'b001; mem[573]=3'b001; mem[574]=3'b001; mem[575]=3'b001; mem[576]=3'b001; mem[577]=3'b001; mem[578]=3'b001; mem[579]=3'b001; mem[580]=3'b001; mem[581]=3'b001; mem[582]=3'b001; mem[583]=3'b001; mem[584]=3'b001; mem[585]=3'b010; mem[586]=3'b000; mem[587]=3'b011; mem[588]=3'b001; mem[589]=3'b001; mem[590]=3'b001; mem[591]=3'b001; mem[592]=3'b001; mem[593]=3'b001; mem[594]=3'b011; mem[595]=3'b001; mem[596]=3'b001; mem[597]=3'b001; mem[598]=3'b001; mem[599]=3'b001; mem[600]=3'b001; mem[601]=3'b001;
mem[602]=3'b001; mem[603]=3'b001; mem[604]=3'b001; mem[605]=3'b001; mem[606]=3'b001; mem[607]=3'b001; mem[608]=3'b001; mem[609]=3'b001; mem[610]=3'b001; mem[611]=3'b001; mem[612]=3'b001; mem[613]=3'b001; mem[614]=3'b001; mem[615]=3'b001; mem[616]=3'b001; mem[617]=3'b001; mem[618]=3'b001; mem[619]=3'b001; mem[620]=3'b001; mem[621]=3'b001; mem[622]=3'b001; mem[623]=3'b001; mem[624]=3'b001; mem[625]=3'b001; mem[626]=3'b001; mem[627]=3'b001; mem[628]=3'b001; mem[629]=3'b001; mem[630]=3'b001; mem[631]=3'b001; mem[632]=3'b001; mem[633]=3'b001; mem[634]=3'b001; mem[635]=3'b001; mem[636]=3'b001; mem[637]=3'b001; mem[638]=3'b001; mem[639]=3'b001; mem[640]=3'b001; mem[641]=3'b001; mem[642]=3'b001; mem[643]=3'b001; mem[644]=3'b001;

end
///////////////////////////////////////////判断hit_wall的条件///////////////////    


// assign cat_win=(cat_x>=53*32);   
 
 
   reg [9:0]mem_xy;
 // assign mem_xy=(cat_y/32-10)*43+(cat_x/32-10)-1;
 //assign mem_xy=((cat_y>>5)-10)*43+((cat_x>>5)-10);  
  //  reg flag_unknown=0;//是否需要？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    
  wire hit_wall_up;
  wire hit_wall_down;
  wire hit_wall_left;
   wire hit_wall_right;
// wire white;
//     always@(posedge clk or negedge rst)
//  begin
//     if(!rst) begin
//        hit_wall<=1;
//        hit_wall_rl<=0;
//   //     white<=0;
//        end
//        else begin
//     if( (mem[  mem_xy ]==2'b01)&&((cat_x>>5==0)||(cat_y>>5==0)))
  assign hit_wall_up=(  (mem[  mem_xy+43 ]==3'b100)|(mem_xy ==435)| (mem_xy ==440)| (mem_xy ==442)| (mem_xy ==392)| ((mem_xy >=396)&&(mem_xy <=400)) );
    assign hit_wall_down=((mem[  mem_xy ]==3'b001)| (mem_xy==489)|(mem_xy==492)|(mem_xy==496)|(mem_xy==504)|(mem_xy==511)|(mem_xy==515)|(mem_xy==473)|(mem_xy==516)|(cat_x<320));
      assign hit_wall_right=((mem[  mem_xy ]==3'b011)| (mem_xy==411));
        assign hit_wall_left=((mem[  mem_xy+1 ]==3'b010)|(mem_xy==417));
//     hit_wall<=1;///////////需要cat_x%32==0吗？？？？？？？？？？？？？？？？？？？？
//  //   else
//   //  hit_wall<=hit_wall;
     
//  else if(mem[ mem_xy ]==2'b11&&((cat_x>>5==0)||(cat_y>>5==0)))
// assign hit_wall_rl=(mem[ mem_xy ]==2'b11);
//   hit_wall_rl<=1;
   
////   else if(mem[ mem_xy ]==2'b00)
//// // assign hit_wall_rl=(mem[ mem_xy ]==2'b11);
////   white<=1;
////   else  begin
//   hit_wall_rl<=hit_wall_rl;
//   hit_wall<=hit_wall;
//   white<
 //  end
//   end
   
//   end   
 //  assign white=~(hit_wall|hit_wall_rl|(mem[  mem_xy  ]==2'b10));
 wire [11:0]c2m_x;
  wire [11:0]c2m_y;
  
  assign c2m_x=((cat_x+16-monster_x)>=0)?(cat_x-monster_x+16):(monster_x-cat_x-16);
  assign c2m_y=((cat_y+32-monster_y)>=0)?(cat_y+32-monster_y):(monster_y-cat_y-32);
 
   assign cat_die=((cat_y>>5)>=24)|((c2m_x<=16)&&(c2m_y<=32)&&(monster_en0==1));
   assign cat_win=(cat_x>=54*32);   
   
   
   
  always@(posedge clk or negedge rst)
  begin
mem_xy=((cat_y>>5)-10)*43+((cat_x>>5)-10);


     if(!rst) begin
  //      cat_die<=0;
//        cat_win<=0;
        hit_unknown1<=0;
        hit_unknown2<=0;
        hit_unknown3<=0;
        
//         hit_wall<=1;
//        hit_wall_rl<=0;
        end
     else begin
//        if( (mem[  mem_xy ]==2'b01)&&((cat_x>>5==0)||(cat_y>>5==0)))
//   //  assign hit_wall=((mem[  mem_xy ]==2'b01)||(mem[mem_xy ]==2'b11));
//     hit_wall<=1;///////////需要cat_x%32==0吗？？？？？？？？？？？？？？？？？？？？
//     else
//     hit_wall<=hit_wall;
     
//  if(mem[ mem_xy ]==2'b11&&((cat_x>>5==0)||(cat_y>>5==0)))
// // assign hit_wall_rl=(mem[ mem_xy ]==2'b11);
//   hit_wall_rl<=1;
//   else
//   hit_wall_rl<=hit_wall_rl;
   
//        if((white==0)&&((cat_y>>5)>=25))
//        cat_die<=1;
//        else
//        cat_die<=cat_die;
   
//         if((cat_x/32)>=53)
//        cat_win<=1;
//        else 
//        cat_win<=cat_win;
//        cat_die<=cat_die;       
      //  if(flag_unknown==0&&mem[   (cat_x>>5-10)*43+(cat_y>>5-10)  ]==2'b10)
      if(  (cat_x>=464)&&(cat_x<=496)&&(cat_y<=656)&&(cat_y>=640))
        begin
         hit_unknown1<=1;
          hit_unknown2<= hit_unknown2;
        hit_unknown3<= hit_unknown3;
       //  flag_unknown<=1;
         end
        else if( (cat_x>=624)&&(cat_x<=656)&&(cat_y<=656)&&(cat_y>=640))
        begin
         hit_unknown2<=1;
            hit_unknown1<= hit_unknown1;
   
        hit_unknown3<= hit_unknown3;
       //  flag_unknown<=1;
         end
       else  if(  (cat_x>=688)&&(cat_x<=720)&&(cat_y<=656)&&(cat_y>=640))
        begin
         hit_unknown3<=1;
          hit_unknown1<= hit_unknown1;
        hit_unknown2<= hit_unknown2;
       //  flag_unknown<=1;
         end
        else  
        begin
         hit_unknown1<= hit_unknown1;
        hit_unknown2<= hit_unknown2;
        hit_unknown3<= hit_unknown3;
        end
       //  flag_unknown<=flag_unknown;
       
//      cat_win=(hit_wall==1)&&((cat_x>>5-10)*43+(cat_y>>5-10)==515);
    
//      hit_unknown=(mem[   (cat_x>>5-10)*43+(cat_y>>5-10)  ]==2'b10);
      end
   end   
   
  // assign white=!(hit_wall||hit_wall_rl);
  
      wire [2:0]direct_en;
    assign direct_en={left_en,right_en,jump_en};  
        reg [31:0]cnt;
        
          always@(posedge clk or negedge rst)
        begin
            if(!rst) begin
			cnt <= 0;			
			cat_x <= 13*32;
			cat_y <= 21*32;
//			ren_hit_wall <= 0;
//			meet<=0;
		    end	
		    
		    else if(game_status==2'b11)begin
		    cnt <= 0;			
			cat_x <= 13*32;
			cat_y <= 21*32;
//			ren_hit_wall <= 0;
//			meet<=0;
		    end	
		    
		    ///////////////////////////////////////meet??????????orfall??????????????????
		    else 
		    begin
		      cnt<=cnt+1;
		      if(cnt==10_000_000)begin///////////大约每秒五次//////////30_000000
		          cnt<=0;
		          if(game_status==0)begin
		              	////////////////////////////墙壁和win？？？？？？？？？？？？？、
		              	case(direct_en)
		              	3'b000:begin
		              	   if(hit_wall_down==0)begin
		              	       cat_y<=cat_y+16;
		              	       cat_x<=cat_x;
		            // 	       down<=0;
		              	       end
		              	    else begin
		              	       cat_y<=cat_y;
		              	       cat_x<=cat_x;
		              	     //  down<=0;  
		              	       end 
		              	   end    
		              	
		              	3'b100:begin

		              	    if(hit_wall_down==0)begin
		              	       cat_y<=cat_y+16;
		              	       cat_x<=cat_x-8;
		              	       down<=0;
		              	       end
		              	   else if(hit_wall_left==1)
		              	   begin
		              	     cat_y<=cat_y;
		              	       cat_x<=cat_x;  
		              	       end   
		              	   else
		              	   cat_x<=cat_x-8;
		              	 end
		              	 3'b010:begin

		              	    if(hit_wall_down==0)begin
		              	       cat_y<=cat_y+16;
		              	       cat_x<=cat_x+8;
		              	       down<=0;
		              	       end
		              	     else if(hit_wall_right==1)
		              	   begin
		              	     cat_y<=cat_y;
		              	       cat_x<=cat_x;  
		              	       end      
		              	   else
		             	   cat_x<=cat_x+8;
		              	 end 
		              	 3'b001:begin
//		              	    if( ( ( cat_x>=14*32&&cat_x<=16*32)|| (cat_x>=18*32&&cat_x<=24*32))
//		              	    &&cat_y>=22*32) 
//		              	    cat_y<=21*32;
//		              	    else  


                            if  (down==0)
		              	    begin
		              	       if(((cat_y0-cat_y)>=32*5)|(hit_wall_up==1)) begin
		              	       cat_y<=cat_y+16;
		              	       down<=1;
		              	       end
		              	       else 
		              	           begin
		              	            //down<=1;///////////////////////////////////32???????????????????????
		              	           cat_y<=cat_y-16;
		              	           //jump_en<=0;//????????/
		              	           end
		              	   end
		              	   else if((down==1)&&(hit_wall_down==0))
		              	       cat_y<=cat_y+16;
		              	  else if(hit_wall_down==1) begin
		              	   cat_y<=cat_y;
		              	   down<=0;   
		              	   end     
		              	  else begin
		              	   cat_y<=cat_y;
		              	   down<=down;
		              	   end
		
		               end
		               
		               
		               3'b011:begin
//		              	    if( ( ( cat_x>=14*32&&cat_x<=16*32)|| (cat_x>=18*32&&cat_x<=24*32))
//		              	    &&cat_y>=22*32) begin
//		              	    cat_y<=21*32;
//		              	    cat_x<=cat_x+8;
//		              	    end
//		              	    else 


		              	    if  (down==0)
		              	    begin
		              	       if(((cat_y0-cat_y)>=32*5)|(hit_wall_up==1)|(hit_wall_right==1))begin
		              	          down<=1;
		              	           /////jump_en<=0????????/
		              	           
		              	       cat_y<=cat_y+16;
		              	       end
		              	       else
		              	           begin
		              	        
		              	           cat_x<=cat_x+8;
		              	       cat_y<=cat_y-16;
		              	           end
		              	   end
		              	   else if((down==1)&&(hit_wall_down==0)&&(hit_wall_right==0))begin
		              	       cat_x<=cat_x+8;
		              	       cat_y<=cat_y+16;
		              	       end
		              	   else if((hit_wall_down==1)||(hit_wall_right==0)) begin
		              	   cat_y<=cat_y;
		              	   cat_x<=cat_x+8;
		              	   down<=0;   
		              	   end 
		              	   
		              	   else if((hit_wall_down==0)||(hit_wall_right==1)) begin
		              	   cat_y<=cat_y-32;
		              	   cat_x<=cat_x;
		              	   end
		              	   
		              	   
		              	  else  begin
		              	   cat_x<=cat_x;
		              	   cat_y<=cat_y;
		              	   end
		
		               end 
		               
		               3'b101:begin
//		              	    if( ( ( cat_x>=14*32&&cat_x<=16*32)|| (cat_x>=18*32&&cat_x<=24*32))
//		              	    &&cat_y>=22*32) begin
//		              	    cat_y<=21*32;
//		              	    cat_x<=cat_x+8;
//		              	    end
//		              	    else 
		              	    if  (down==0)///////////要改成跟上面一样吗？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
		              	    begin
		              	       if(((cat_y0-cat_y)>=32*5)|(hit_wall_up==1)|(hit_wall_left==1))begin
		              	          down<=1;
		              	           /////jump_en<=0????????/
		              	           
		              	      cat_y<=cat_y+16;
		              	       end
		              	       else
		              	           begin
		              	        
		              	           cat_x<=cat_x-8;
		              	       cat_y<=cat_y-16;
		              	           end
		              	   end
		              	   else if((down==1)&&(hit_wall_down==0)&&(hit_wall_left==0))begin
		              	       cat_x<=cat_x-8;
		              	       cat_y<=cat_y+16;
		              	       end
		              	   else if((hit_wall_down==1)||(hit_wall_left==0)) begin
		              	   cat_y<=cat_y;
		              	   cat_x<=cat_x-8;
		              	   down<=0;   
		              	   end 
		              	   
		              	   else if((hit_wall_down==0)||(hit_wall_left==1)) begin
		              	   cat_y<=cat_y-32;
		              	   cat_x<=cat_x;
		              	   end
		              	   
		              	   
		              	  else  begin
		              	   cat_x<=cat_x;
		              	   cat_y<=cat_y;
		              	   end
		
		               end 
		               
		              	 default:begin
		              	 cat_x<=cat_x;
		              	 cat_y<=cat_y;
		              	 end
		              	 endcase
		             end 	 
		        end
		   end
	end	    
endmodule