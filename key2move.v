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
    output reg [11:0]cat_x=13*32,//=12'd90,是否可以赋初值？？？？？？？？？？？？？？？？？？？
    output reg [11:0]cat_y=21*32,//=12'd840,
    output   cat_win,//////////////需要reg吗????????????????????????????????????????
    output   cat_die,
    output  reg hit_unknown
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

                if(left_i==2'b10)
                    left_en <= 1;
    //            if(right_key_last == 0 && key_right == 1)
                else if(left_i==2'b01)
                    left_en <= 0;
                else if(right_i==2'b10)
                    right_en <= 1;
                    else if(right_i==2'b01)
                    right_en <=0;
     //           if(jump_key_last == 0 && key_jump == 1)
                else  if(jump_i==2'b10)
                    jump_en <= 1;
                    else  if(jump_i==2'b01)
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
    if(jump_i==2'b10)
    cat_y0<=cat_y;
//    else if(jump_i==2'b01)
//    down<=0;
    //cat_y0<=cat_y0;//////////////////////////??????????????????????????/
    end
    
  
  ////////////////////////////////////////////对地图分块标记/////////////////////
   reg[1:0] mem[0:644]; 
   initial
begin
mem[0]=2'b11;   mem[1]=2'b01;   mem[2]=2'b01;   mem[3]=2'b01;   mem[4]=2'b01;   mem[5]=2'b01;   mem[6]=2'b01;   
mem[7]=2'b01;   mem[8]=2'b01;   mem[9]=2'b01;   mem[10]=2'b01;  mem[11]=2'b01;  mem[12]=2'b01;  mem[13]=2'b01;  
mem[14]=2'b01;  mem[15]=2'b01;  mem[16]=2'b01;  mem[17]=2'b01;  mem[18]=2'b01;  mem[19]=2'b01;  mem[20]=2'b01;  
mem[21]=2'b01;  mem[22]=2'b01;  mem[23]=2'b01;  mem[24]=2'b01;  mem[25]=2'b01;  mem[26]=2'b01;  mem[27]=2'b01;  
mem[28]=2'b01;  mem[29]=2'b01;  mem[30]=2'b01;  mem[31]=2'b01;  mem[32]=2'b01;  mem[33]=2'b01;  mem[34]=2'b01;  
mem[35]=2'b01;  mem[36]=2'b01;  mem[37]=2'b01;  mem[38]=2'b01;  mem[39]=2'b01;  mem[40]=2'b01;  mem[41]=2'b01;  
mem[42]=2'b01;  
mem[43]=2'b11;  mem[44]=2'b00;  mem[45]=2'b00;  mem[46]=2'b00;  mem[47]=2'b00;  mem[48]=2'b00;  mem[49]=2'b00;  
mem[50]=2'b00;  mem[51]=2'b00;  mem[52]=2'b00;  mem[53]=2'b00;  mem[54]=2'b00;  mem[55]=2'b00;  mem[56]=2'b00;  
mem[57]=2'b00;  mem[58]=2'b00;  mem[59]=2'b00;  mem[60]=2'b00;  mem[61]=2'b00;  mem[62]=2'b00;  mem[63]=2'b00;  
mem[64]=2'b00;  mem[65]=2'b00;  mem[66]=2'b00;  mem[67]=2'b00;  mem[68]=2'b00;  mem[69]=2'b00;  mem[70]=2'b00;  
mem[71]=2'b00;  mem[72]=2'b00;  mem[73]=2'b00;  mem[74]=2'b00;  mem[75]=2'b00;  mem[76]=2'b00;  mem[77]=2'b00;  
mem[78]=2'b00;  mem[79]=2'b00;  mem[80]=2'b00;  mem[81]=2'b00;  mem[82]=2'b00;  mem[83]=2'b00;  mem[84]=2'b00;  
mem[85]=2'b11;  
mem[86]=2'b11;  mem[87]=2'b00;  mem[88]=2'b00;  mem[89]=2'b00;  mem[90]=2'b00;  mem[91]=2'b00;  mem[92]=2'b00;  
mem[93]=2'b00;  mem[94]=2'b00;  mem[95]=2'b00;  mem[96]=2'b00;  mem[97]=2'b00;  mem[98]=2'b00;  mem[99]=2'b00;  
mem[100]=2'b00; mem[101]=2'b00; mem[102]=2'b00; mem[103]=2'b00; mem[104]=2'b00; mem[105]=2'b00; mem[106]=2'b00; 
mem[107]=2'b00; mem[108]=2'b00; mem[109]=2'b00; mem[110]=2'b00; mem[111]=2'b00; mem[112]=2'b00; mem[113]=2'b00; 
mem[114]=2'b00; mem[115]=2'b00; mem[116]=2'b00; mem[117]=2'b00; mem[118]=2'b00; mem[119]=2'b00; mem[120]=2'b00; 
mem[121]=2'b00; mem[122]=2'b00; mem[123]=2'b00; mem[124]=2'b00; mem[125]=2'b00; mem[126]=2'b00; mem[127]=2'b00; 
mem[128]=2'b11; 
mem[129]=2'b11; mem[130]=2'b00; mem[131]=2'b00; mem[132]=2'b00; mem[133]=2'b00; mem[134]=2'b00; mem[135]=2'b00; 
mem[136]=2'b00; mem[137]=2'b00; mem[138]=2'b00; mem[139]=2'b00; mem[140]=2'b00; mem[141]=2'b00; mem[142]=2'b00; 
mem[143]=2'b00; mem[144]=2'b00; mem[145]=2'b00; mem[146]=2'b00; mem[147]=2'b00; mem[148]=2'b00; mem[149]=2'b00; 
mem[150]=2'b00; mem[151]=2'b00; mem[152]=2'b00; mem[153]=2'b00; mem[154]=2'b00; mem[155]=2'b00; mem[156]=2'b00; 
mem[157]=2'b00; mem[158]=2'b00; mem[159]=2'b00; mem[160]=2'b00; mem[161]=2'b00; mem[162]=2'b00; mem[163]=2'b00; 
mem[164]=2'b00; mem[165]=2'b00; mem[166]=2'b00; mem[167]=2'b00; mem[168]=2'b00; mem[169]=2'b00; mem[170]=2'b00; 
mem[171]=2'b11; 
mem[172]=2'b11; mem[173]=2'b00; mem[174]=2'b00; mem[175]=2'b00; mem[176]=2'b00; mem[177]=2'b00; mem[178]=2'b00; 
mem[179]=2'b00; mem[180]=2'b00; mem[181]=2'b00; mem[182]=2'b00; mem[183]=2'b00; mem[184]=2'b00; mem[185]=2'b00; 
mem[186]=2'b00; mem[187]=2'b00; mem[188]=2'b00; mem[189]=2'b00; mem[190]=2'b00; mem[191]=2'b00; mem[192]=2'b00; 
mem[193]=2'b00; mem[194]=2'b00; mem[195]=2'b00; mem[196]=2'b00; mem[197]=2'b00; mem[198]=2'b00; mem[199]=2'b00; 
mem[200]=2'b00; mem[201]=2'b00; mem[202]=2'b00; mem[203]=2'b00; mem[204]=2'b00; mem[205]=2'b00; mem[206]=2'b00; 
mem[207]=2'b00; mem[208]=2'b00; mem[209]=2'b00; mem[210]=2'b00; mem[211]=2'b00; mem[212]=2'b00; mem[213]=2'b00; 
mem[214]=2'b11; 
mem[215]=2'b11; mem[216]=2'b00; mem[217]=2'b00; mem[218]=2'b00; mem[219]=2'b00; mem[220]=2'b00; mem[221]=2'b00; 
mem[222]=2'b00; mem[223]=2'b00; mem[224]=2'b00; mem[225]=2'b00; mem[226]=2'b00; mem[227]=2'b00; mem[228]=2'b00; 
mem[229]=2'b00; mem[230]=2'b00; mem[231]=2'b00; mem[232]=2'b00; mem[233]=2'b00; mem[234]=2'b00; mem[235]=2'b00; 
mem[236]=2'b00; mem[237]=2'b00; mem[238]=2'b00; mem[239]=2'b00; mem[240]=2'b00; mem[241]=2'b00; mem[242]=2'b00; 
mem[243]=2'b00; mem[244]=2'b00; mem[245]=2'b00; mem[246]=2'b00; mem[247]=2'b00; mem[248]=2'b00; mem[249]=2'b00; 
mem[250]=2'b00; mem[251]=2'b00; mem[252]=2'b00; mem[253]=2'b00; mem[254]=2'b00; mem[255]=2'b00; mem[256]=2'b00; 
mem[257]=2'b11; 
mem[258]=2'b11; mem[259]=2'b00; mem[260]=2'b00; mem[261]=2'b00; mem[262]=2'b00; mem[263]=2'b00; mem[264]=2'b00; 
mem[265]=2'b00; mem[266]=2'b00; mem[267]=2'b00; mem[268]=2'b00; mem[269]=2'b00; mem[270]=2'b00; mem[271]=2'b00; 
mem[272]=2'b00; mem[273]=2'b00; mem[274]=2'b00; mem[275]=2'b00; mem[276]=2'b00; mem[277]=2'b00; mem[278]=2'b00; 
mem[279]=2'b00; mem[280]=2'b00; mem[281]=2'b00; mem[282]=2'b00; mem[283]=2'b00; mem[284]=2'b00; mem[285]=2'b00; 
mem[286]=2'b00; mem[287]=2'b00; mem[288]=2'b00; mem[289]=2'b00; mem[290]=2'b00; mem[291]=2'b00; mem[292]=2'b00; 
mem[293]=2'b00; mem[294]=2'b00; mem[295]=2'b00; mem[296]=2'b00; mem[297]=2'b00; mem[298]=2'b00; mem[299]=2'b00; 
mem[300]=2'b11; 
mem[301]=2'b11; mem[302]=2'b00; mem[303]=2'b00; mem[304]=2'b00; mem[305]=2'b00; mem[306]=2'b01; mem[307]=2'b00; 
mem[308]=2'b00; mem[309]=2'b00; mem[310]=2'b01; mem[311]=2'b01; mem[312]=2'b01; mem[313]=2'b01; mem[314]=2'b01; 
mem[315]=2'b00; mem[316]=2'b00; mem[317]=2'b00; mem[318]=2'b00; mem[319]=2'b00; mem[320]=2'b00; mem[321]=2'b00; 
mem[322]=2'b00; mem[323]=2'b00; mem[324]=2'b00; mem[325]=2'b00; mem[326]=2'b00; mem[327]=2'b00; mem[328]=2'b00; 
mem[329]=2'b00; mem[330]=2'b00; mem[331]=2'b00; mem[332]=2'b00; mem[333]=2'b00; mem[334]=2'b00; mem[335]=2'b00; 
mem[336]=2'b00; mem[337]=2'b00; mem[338]=2'b00; mem[339]=2'b00; mem[340]=2'b00; mem[341]=2'b00; mem[342]=2'b00; 
mem[343]=2'b11; 
mem[344]=2'b11; mem[345]=2'b00; mem[346]=2'b00; mem[347]=2'b00; mem[348]=2'b11; mem[349]=2'b00; mem[350]=2'b11; 
mem[351]=2'b00; mem[352]=2'b11; mem[353]=2'b00; mem[354]=2'b00; mem[355]=2'b00; mem[356]=2'b00; mem[357]=2'b00; 
mem[358]=2'b11; mem[359]=2'b00; mem[360]=2'b01; mem[361]=2'b01; mem[362]=2'b01; mem[363]=2'b01; mem[364]=2'b00; 
mem[365]=2'b00; mem[366]=2'b00; mem[367]=2'b00; mem[368]=2'b01; mem[369]=2'b01; mem[370]=2'b00; mem[371]=2'b00; 
mem[372]=2'b00; mem[373]=2'b01; mem[374]=2'b01; mem[375]=2'b00; mem[376]=2'b00; mem[377]=2'b00; mem[378]=2'b00; 
mem[379]=2'b00; mem[380]=2'b01; mem[381]=2'b01; mem[382]=2'b01; mem[383]=2'b00; mem[384]=2'b00; mem[385]=2'b00; 
mem[386]=2'b11; 
mem[387]=2'b11; mem[388]=2'b00; mem[389]=2'b00; mem[390]=2'b00; mem[391]=2'b11; mem[392]=2'b00; mem[393]=2'b11; 
mem[394]=2'b00; mem[395]=2'b11; mem[396]=2'b01; mem[397]=2'b01; mem[398]=2'b01; mem[399]=2'b01; mem[400]=2'b01; 
mem[401]=2'b11; mem[402]=2'b00; mem[403]=2'b11; mem[404]=2'b00; mem[405]=2'b00; mem[406]=2'b11; mem[407]=2'b00; 
mem[408]=2'b00; mem[409]=2'b00; mem[410]=2'b01; mem[411]=2'b11; mem[412]=2'b00; mem[413]=2'b11; mem[414]=2'b00; 
mem[415]=2'b11; mem[416]=2'b00; mem[417]=2'b11; mem[418]=2'b01; mem[419]=2'b00; mem[420]=2'b00; mem[421]=2'b00; 
mem[422]=2'b11; mem[423]=2'b00; mem[424]=2'b00; mem[425]=2'b11; mem[426]=2'b00; mem[427]=2'b00; mem[428]=2'b00; 
mem[429]=2'b11; 
mem[430]=2'b11; mem[431]=2'b00; mem[432]=2'b00; mem[433]=2'b00; mem[434]=2'b00; mem[435]=2'b10; mem[436]=2'b00; 
mem[437]=2'b00; mem[438]=2'b00; mem[439]=2'b00; mem[440]=2'b10; mem[441]=2'b00; mem[442]=2'b10; mem[443]=2'b00; 
mem[444]=2'b00; mem[445]=2'b00; mem[446]=2'b11; mem[447]=2'b00; mem[448]=2'b00; mem[449]=2'b11; mem[450]=2'b00; 
mem[451]=2'b00; mem[452]=2'b00; mem[453]=2'b11; mem[454]=2'b00; mem[455]=2'b00; mem[456]=2'b11; mem[457]=2'b00; 
mem[458]=2'b11; mem[459]=2'b00; mem[460]=2'b00; mem[461]=2'b11; mem[462]=2'b00; mem[463]=2'b00; mem[464]=2'b00; 
mem[465]=2'b11; mem[466]=2'b00; mem[467]=2'b00; mem[468]=2'b11; mem[469]=2'b00; mem[470]=2'b00; mem[471]=2'b00; 
mem[472]=2'b11; 
mem[473]=2'b11; mem[474]=2'b01; mem[475]=2'b01; mem[476]=2'b01; mem[477]=2'b01; mem[478]=2'b01; mem[479]=2'b01; 
mem[480]=2'b01; mem[481]=2'b01; mem[482]=2'b01; mem[483]=2'b01; mem[484]=2'b01; mem[485]=2'b01; mem[486]=2'b01; 
mem[487]=2'b01; mem[488]=2'b01; mem[489]=2'b11; mem[490]=2'b00; mem[491]=2'b00; mem[492]=2'b11; mem[493]=2'b01; 
mem[494]=2'b01; mem[495]=2'b01; mem[496]=2'b11; mem[497]=2'b00; mem[498]=2'b00; mem[499]=2'b11; mem[500]=2'b00; 
mem[501]=2'b11; mem[502]=2'b00; mem[503]=2'b00; mem[504]=2'b11; mem[505]=2'b01; mem[506]=2'b01; mem[507]=2'b01; 
mem[508]=2'b11; mem[509]=2'b00; mem[510]=2'b00; mem[511]=2'b11; mem[512]=2'b01; mem[513]=2'b01; mem[514]=2'b01; 
mem[515]=2'b11; 
mem[516]=2'b01; mem[517]=2'b01; mem[518]=2'b01; mem[519]=2'b01; mem[520]=2'b01; mem[521]=2'b01; mem[522]=2'b01; 
mem[523]=2'b01; mem[524]=2'b01; mem[525]=2'b01; mem[526]=2'b01; mem[527]=2'b01; mem[528]=2'b01; mem[529]=2'b01; 
mem[530]=2'b01; mem[531]=2'b01; mem[532]=2'b01; mem[533]=2'b01; mem[534]=2'b01; mem[535]=2'b01; mem[536]=2'b01; 
mem[537]=2'b01; mem[538]=2'b01; mem[539]=2'b01; mem[540]=2'b01; mem[541]=2'b01; mem[542]=2'b11; mem[543]=2'b01; 
mem[544]=2'b11; mem[545]=2'b01; mem[546]=2'b01; mem[547]=2'b01; mem[548]=2'b01; mem[549]=2'b01; mem[550]=2'b01; 
mem[551]=2'b11; mem[552]=2'b01; mem[553]=2'b01; mem[554]=2'b01; mem[555]=2'b01; mem[556]=2'b01; mem[557]=2'b01; 
mem[558]=2'b01; 
mem[559]=2'b01; mem[560]=2'b01; mem[561]=2'b01; mem[562]=2'b01; mem[563]=2'b01; mem[564]=2'b01; mem[565]=2'b01; 
mem[566]=2'b01; mem[567]=2'b01; mem[568]=2'b01; mem[569]=2'b01; mem[570]=2'b01; mem[571]=2'b01; mem[572]=2'b01; 
mem[573]=2'b01; mem[574]=2'b01; mem[575]=2'b01; mem[576]=2'b01; mem[577]=2'b01; mem[578]=2'b01; mem[579]=2'b01; 
mem[580]=2'b01; mem[581]=2'b01; mem[582]=2'b01; mem[583]=2'b01; mem[584]=2'b01; mem[585]=2'b11; mem[586]=2'b00; 
mem[587]=2'b11; mem[588]=2'b01; mem[589]=2'b01; mem[590]=2'b01; mem[591]=2'b01; mem[592]=2'b01; mem[593]=2'b01; 
mem[594]=2'b11; mem[595]=2'b01; mem[596]=2'b01; mem[597]=2'b01; mem[598]=2'b01; mem[599]=2'b01; mem[600]=2'b01; 
mem[601]=2'b01;
mem[602]=2'b01; mem[603]=2'b01; mem[604]=2'b01; mem[605]=2'b01; mem[606]=2'b01; mem[607]=2'b01; mem[608]=2'b01; 
mem[609]=2'b01; mem[610]=2'b01; mem[611]=2'b01; mem[612]=2'b01; mem[613]=2'b01; mem[614]=2'b01; mem[615]=2'b01; 
mem[616]=2'b01; mem[617]=2'b01; mem[618]=2'b01; mem[619]=2'b01; mem[620]=2'b01; mem[621]=2'b01; mem[622]=2'b01; 
mem[623]=2'b01; mem[624]=2'b01; mem[625]=2'b01; mem[626]=2'b01; mem[627]=2'b01; mem[628]=2'b01; mem[629]=2'b01; 
mem[630]=2'b01; mem[631]=2'b01; mem[632]=2'b01; mem[633]=2'b01; mem[634]=2'b01; mem[635]=2'b01; mem[636]=2'b01; 
mem[637]=2'b01; mem[638]=2'b01; mem[639]=2'b01; mem[640]=2'b01; mem[641]=2'b01; mem[642]=2'b01; mem[643]=2'b01; 
mem[644]=2'b01;

end
///////////////////////////////////////////判断hit_wall的条件///////////////////    


// assign cat_win=(cat_x>=53*32);   
 
 
   reg [9:0]mem_xy;
 // assign mem_xy=(cat_y/32-10)*43+(cat_x/32-10)-1;
 //assign mem_xy=((cat_y>>5)-10)*43+((cat_x>>5)-10);  
  //  reg flag_unknown=0;//是否需要？？？？？？？？？？？？？？？？？？？？？？？？？？？？？？
    
  wire hit_wall;
   wire hit_wall_rl;
 wire white;
//     always@(posedge clk or negedge rst)
//  begin
//     if(!rst) begin
//        hit_wall<=1;
//        hit_wall_rl<=0;
//   //     white<=0;
//        end
//        else begin
//     if( (mem[  mem_xy ]==2'b01)&&((cat_x>>5==0)||(cat_y>>5==0)))
  assign hit_wall=(mem[  mem_xy ]==2'b01);
//     hit_wall<=1;///////////需要cat_x%32==0吗？？？？？？？？？？？？？？？？？？？？
//  //   else
//   //  hit_wall<=hit_wall;
     
//  else if(mem[ mem_xy ]==2'b11&&((cat_x>>5==0)||(cat_y>>5==0)))
 assign hit_wall_rl=(mem[ mem_xy ]==2'b11);
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
   assign white=~(hit_wall|hit_wall_rl|(mem[  mem_xy  ]==2'b10));
   assign cat_die=((cat_y>>5)>=24);
   assign cat_win=(cat_x>=53*32);   
   
   
   
  always@(posedge clk or negedge rst)
  begin
mem_xy=((cat_y>>5)-10)*43+((cat_x>>5)-10);


     if(!rst) begin
  //      cat_die<=0;
//        cat_win<=0;
        hit_unknown<=0;
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
      if(mem[  mem_xy  ]==2'b10)
        begin
         hit_unknown<=1;
       //  flag_unknown<=1;
         end
        else 
         hit_unknown<= hit_unknown;
      
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
		              	   if(hit_wall==0)begin
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

		              	    if(white==1)begin
		              	       cat_y<=cat_y+16;
		              	       cat_x<=cat_x-8;
		              	       down<=0;
		              	       end
		              	   else if(hit_wall_rl==1)
		              	   begin
		              	     cat_y<=cat_y;
		              	       cat_x<=cat_x;  
		              	       end   
		              	   else
		              	   cat_x<=cat_x-8;
		              	 end
		              	 3'b010:begin

		              	    if(white==1)begin
		              	       cat_y<=cat_y+16;
		              	       cat_x<=cat_x+8;
		              	       down<=0;
		              	       end
		              	     else if(hit_wall_rl==1)
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
		              	       if((cat_y0-cat_y)>=32*5) begin
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
		              	   else if((down==1)&&(white==1))
		              	       cat_y<=cat_y+16;
		              	  else if(white==0) begin
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
		              	       if((cat_y0-cat_y)>=32*5)begin
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
		              	   else if((down==1)&&(white==1))begin
		              	       cat_x<=cat_x+8;
		              	       cat_y<=cat_y+16;
		              	       end
		              	   else if(white==0) begin
		              	   cat_y<=cat_y;
		              	   cat_x<=cat_x+8;
		              	   down<=0;   
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
		              	       if((cat_y0-cat_y)>=32*5)begin
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
		              	   else if((down==1)&&(white==1))begin
		              	       cat_x<=cat_x-8;
		              	       cat_y<=cat_y+16;
		              	       end
		              	   else if(white==0) begin
		              	   cat_y<=cat_y;
		              	   cat_x<=cat_x-8;
		              	   down<=0;   
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