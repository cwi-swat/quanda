import java.util.*;
import java.io.*;
public class Quanda {
  public static void main(String args[]) {
    Map<String, String> env = new HashMap<String, String>();
    Quanda q = new Quanda();
    q.dispatch(new Scanner(System.in), new PrintWriter(System.out), env);
    System.out.println(env);
  }
  
  public void dispatch(Scanner input, PrintWriter output, Map<String, String> env) {
     int current = 24;
     while (true) {
       switch (current) {
         
         case 0: { 
           render_0(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_0(env, q, a);
           break;
           
         }
         
         case 1: { 
           render_1(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_1(env, q, a);
           break;
           
         }
         
         case 2: { 
           render_2(output, env);
           output.flush();
           
           return;
           
         }
         
         case 3: { 
           render_3(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_3(env, q, a);
           break;
           
         }
         
         case 4: { 
           render_4(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_4(env, q, a);
           break;
           
         }
         
         case 5: { 
           render_5(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_5(env, q, a);
           break;
           
         }
         
         case 6: { 
           render_6(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_6(env, q, a);
           break;
           
         }
         
         case 7: { 
           render_7(output, env);
           output.flush();
           
           return;
           
         }
         
         case 8: { 
           render_8(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_8(env, q, a);
           break;
           
         }
         
         case 9: { 
           render_9(output, env);
           output.flush();
           
           return;
           
         }
         
         case 10: { 
           render_10(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_10(env, q, a);
           break;
           
         }
         
         case 11: { 
           render_11(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_11(env, q, a);
           break;
           
         }
         
         case 12: { 
           render_12(output, env);
           output.flush();
           
           return;
           
         }
         
         case 13: { 
           render_13(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_13(env, q, a);
           break;
           
         }
         
         case 14: { 
           render_14(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_14(env, q, a);
           break;
           
         }
         
         case 15: { 
           render_15(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_15(env, q, a);
           break;
           
         }
         
         case 16: { 
           render_16(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_16(env, q, a);
           break;
           
         }
         
         case 17: { 
           render_17(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_17(env, q, a);
           break;
           
         }
         
         case 18: { 
           render_18(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_18(env, q, a);
           break;
           
         }
         
         case 19: { 
           render_19(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_19(env, q, a);
           break;
           
         }
         
         case 20: { 
           render_20(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_20(env, q, a);
           break;
           
         }
         
         case 21: { 
           render_21(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_21(env, q, a);
           break;
           
         }
         
         case 22: { 
           render_22(output, env);
           output.flush();
           
           return;
           
         }
         
         case 23: { 
           render_23(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_23(env, q, a);
           break;
           
         }
         
         case 24: { 
           render_24(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_24(env, q, a);
           break;
           
         }
         
         case 25: { 
           render_25(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_25(env, q, a);
           break;
           
         }
         
         case 26: { 
           render_26(output, env);
           output.flush();
           
           return;
           
         }
         
         case 27: { 
           render_27(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_27(env, q, a);
           break;
           
         }
         
         case 28: { 
           render_28(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_28(env, q, a);
           break;
           
         }
         
         case 29: { 
           render_29(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_29(env, q, a);
           break;
           
         }
         
         case 30: { 
           render_30(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_30(env, q, a);
           break;
           
         }
         
         case 31: { 
           render_31(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_31(env, q, a);
           break;
           
         }
         
         case 32: { 
           render_32(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_32(env, q, a);
           break;
           
         }
         
         case 33: { 
           render_33(output, env);
           output.flush();
           
           return;
           
         }
         
         case 34: { 
           render_34(output, env);
           output.flush();
           
           return;
           
         }
         
         case 35: { 
           render_35(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_35(env, q, a);
           break;
           
         }
         
         case 36: { 
           render_36(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_36(env, q, a);
           break;
           
         }
         
         case 37: { 
           render_37(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_37(env, q, a);
           break;
           
         }
         
         case 38: { 
           render_38(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_38(env, q, a);
           break;
           
         }
         
         case 39: { 
           render_39(output, env);
           output.flush();
           
           return;
           
         }
         
         case 40: { 
           render_40(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_40(env, q, a);
           break;
           
         }
         
         case 41: { 
           render_41(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_41(env, q, a);
           break;
           
         }
         
         case 42: { 
           render_42(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_42(env, q, a);
           break;
           
         }
         
         case 43: { 
           render_43(output, env);
           output.flush();
           
           return;
           
         }
         
         case 44: { 
           render_44(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_44(env, q, a);
           break;
           
         }
         
         case 45: { 
           render_45(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_45(env, q, a);
           break;
           
         }
         
         case 46: { 
           render_46(output, env);
           output.flush();
           
           return;
           
         }
         
         case 47: { 
           render_47(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_47(env, q, a);
           break;
           
         }
         
         case 48: { 
           render_48(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_48(env, q, a);
           break;
           
         }
         
         case 49: { 
           render_49(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_49(env, q, a);
           break;
           
         }
         
         case 50: { 
           render_50(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_50(env, q, a);
           break;
           
         }
         
         case 51: { 
           render_51(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_51(env, q, a);
           break;
           
         }
         
         case 52: { 
           render_52(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_52(env, q, a);
           break;
           
         }
         
         case 53: { 
           render_53(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_53(env, q, a);
           break;
           
         }
         
         case 54: { 
           render_54(output, env);
           output.flush();
           
           return;
           
         }
         
         case 55: { 
           render_55(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_55(env, q, a);
           break;
           
         }
         
         case 56: { 
           render_56(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_56(env, q, a);
           break;
           
         }
         
         case 57: { 
           render_57(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_57(env, q, a);
           break;
           
         }
         
         case 58: { 
           render_58(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_58(env, q, a);
           break;
           
         }
         
         case 59: { 
           render_59(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_59(env, q, a);
           break;
           
         }
         
         case 60: { 
           render_60(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_60(env, q, a);
           break;
           
         }
         
         case 61: { 
           render_61(output, env);
           output.flush();
           
           int q = Integer.parseInt(input.nextLine());
           String a = input.nextLine();
           current = handle_61(env, q, a);
           break;
           
         }
         
       }
    }
  }
           
  public int handle_0(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("uni", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_sc  && b_wz ) {  
        return 6;
      }
      
      if (true  && b_wz ) {  
        return 18;
      }
      
      if (true  && b_sc ) {  
        return 51;
      }
      
      if (true ) {  
        return 54;
      }
      
    }
    
    return -1;     
  }
  public int handle_1(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      
      if (true ) {  
        return 2;
      }
      
    }
    
    return -1;     
  }
  public int handle_2(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_3(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 10;
      }
      
      if (true ) {  
        return 59;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 49;
      }
      
      if (true ) {  
        return 4;
      }
      
    }
    
    return -1;     
  }
  public int handle_4(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 21;
      }
      
      if (true ) {  
        return 39;
      }
      
    }
    
    return -1;     
  }
  public int handle_5(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_sc  && b_wz  && b_uni ) {  
        return 58;
      }
      
      if (true  && b_sc  && b_uni ) {  
        return 16;
      }
      
      if (true  && b_wz  && b_uni ) {  
        return 53;
      }
      
      if (true  && b_sc  && b_wz ) {  
        return 45;
      }
      
      if (true  && b_uni ) {  
        return 0;
      }
      
      if (true  && b_wz ) {  
        return 38;
      }
      
      if (true  && b_sc ) {  
        return 29;
      }
      
      if (true ) {  
        return 26;
      }
      
    }
    
    return -1;     
  }
  public int handle_6(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 49;
      }
      
      if (true ) {  
        return 60;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("wz", theAnswer);
      
      
      if (true ) {  
        return 23;
      }
      
    }
    
    return -1;     
  }
  public int handle_7(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_8(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("uni", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      
      if (true  && b_sc ) {  
        return 23;
      }
      
      if (true ) {  
        return 34;
      }
      
    }
    
    return -1;     
  }
  public int handle_9(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_10(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      
      if (true ) {  
        return 56;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 21;
      }
      
    }
    
    return -1;     
  }
  public int handle_11(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("uni", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_cijfer  && b_wz ) {  
        return 49;
      }
      
      if (true  && b_cijfer ) {  
        return 4;
      }
      
      if (true  && b_wz ) {  
        return 60;
      }
      
      if (true ) {  
        return 12;
      }
      
    }
    
    return -1;     
  }
  public int handle_12(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_13(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 30;
      }
      
      if (true ) {  
        return 19;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 23;
      }
      
    }
    
    return -1;     
  }
  public int handle_14(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("vo", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_sc  && b_wz  && b_uni ) {  
        return 58;
      }
      
      if (true  && b_sc  && b_wz ) {  
        return 45;
      }
      
      if (true  && b_wz  && b_uni ) {  
        return 53;
      }
      
      if (true  && b_sc  && b_uni ) {  
        return 16;
      }
      
      if (true  && b_uni ) {  
        return 0;
      }
      
      if (true  && b_sc ) {  
        return 29;
      }
      
      if (true  && b_wz ) {  
        return 38;
      }
      
      if (true ) {  
        return 26;
      }
      
    }
    
    return -1;     
  }
  public int handle_15(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_uni ) {  
        return 56;
      }
      
      if (true ) {  
        return 46;
      }
      
    }
    
    return -1;     
  }
  public int handle_16(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_cijfer  && b_wz ) {  
        return 50;
      }
      
      if (true  && b_wz ) {  
        return 61;
      }
      
      if (true  && b_cijfer ) {  
        return 3;
      }
      
      if (true ) {  
        return 11;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 6;
      }
      
      if (true ) {  
        return 51;
      }
      
    }
    
    return -1;     
  }
  public int handle_17(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_cijfer  && b_uni ) {  
        return 44;
      }
      
      if (true  && b_uni ) {  
        return 40;
      }
      
      if (true  && b_cijfer ) {  
        return 55;
      }
      
      if (true ) {  
        return 47;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_wz  && b_uni ) {  
        return 58;
      }
      
      if (true  && b_wz ) {  
        return 45;
      }
      
      if (true  && b_uni ) {  
        return 16;
      }
      
      if (true ) {  
        return 29;
      }
      
    }
    
    return -1;     
  }
  public int handle_18(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      
      if (true  && b_sc ) {  
        return 23;
      }
      
      if (true ) {  
        return 34;
      }
      
    }
    
    return -1;     
  }
  public int handle_19(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("uni", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 1;
      }
      
      if (true ) {  
        return 9;
      }
      
    }
    
    return -1;     
  }
  public int handle_20(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 21;
      }
      
      if (true ) {  
        return 39;
      }
      
    }
    
    return -1;     
  }
  public int handle_21(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      
      if (true ) {  
        return 2;
      }
      
    }
    
    return -1;     
  }
  public int handle_22(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_23(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 1;
      }
      
      if (true ) {  
        return 9;
      }
      
    }
    
    return -1;     
  }
  public int handle_24(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      
      if (true ) {  
        return 14;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("vo", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_sc  && b_uni ) {  
        return 31;
      }
      
      if (true  && b_uni ) {  
        return 27;
      }
      
      if (true  && b_sc ) {  
        return 17;
      }
      
      if (true ) {  
        return 5;
      }
      
    }
    
    return -1;     
  }
  public int handle_25(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 49;
      }
      
      if (true ) {  
        return 4;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("cijfer", theAnswer);
      
      
      if (true ) {  
        return 20;
      }
      
    }
    
    return -1;     
  }
  public int handle_26(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_27(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_sc  && b_wz ) {  
        return 58;
      }
      
      if (true  && b_sc ) {  
        return 16;
      }
      
      if (true  && b_wz ) {  
        return 53;
      }
      
      if (true ) {  
        return 0;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      
      if (true  && b_sc ) {  
        return 57;
      }
      
      if (true ) {  
        return 52;
      }
      
    }
    
    return -1;     
  }
  public int handle_28(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_wz  && b_uni ) {  
        return 10;
      }
      
      if (true  && b_uni ) {  
        return 59;
      }
      
      if (true  && b_wz ) {  
        return 36;
      }
      
      if (true ) {  
        return 43;
      }
      
    }
    
    return -1;     
  }
  public int handle_29(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_cijfer  && b_wz  && b_uni ) {  
        return 50;
      }
      
      if (true  && b_wz  && b_uni ) {  
        return 61;
      }
      
      if (true  && b_cijfer  && b_uni ) {  
        return 3;
      }
      
      if (true  && b_cijfer  && b_wz ) {  
        return 37;
      }
      
      if (true  && b_cijfer ) {  
        return 28;
      }
      
      if (true  && b_uni ) {  
        return 11;
      }
      
      if (true  && b_wz ) {  
        return 42;
      }
      
      if (true ) {  
        return 33;
      }
      
    }
    
    return -1;     
  }
  public int handle_30(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      
      if (true ) {  
        return 56;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 1;
      }
      
    }
    
    return -1;     
  }
  public int handle_31(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 44;
      }
      
      if (true ) {  
        return 40;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 58;
      }
      
      if (true ) {  
        return 16;
      }
      
    }
    
    if (theQuestion == 2) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 57;
      }
      
    }
    
    return -1;     
  }
  public int handle_32(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_cijfer  && b_wz ) {  
        return 49;
      }
      
      if (true  && b_cijfer ) {  
        return 4;
      }
      
      if (true  && b_wz ) {  
        return 60;
      }
      
      if (true ) {  
        return 12;
      }
      
    }
    
    return -1;     
  }
  public int handle_33(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_34(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_35(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_cijfer  && b_uni ) {  
        return 30;
      }
      
      if (true  && b_cijfer ) {  
        return 15;
      }
      
      if (true  && b_uni ) {  
        return 19;
      }
      
      if (true ) {  
        return 7;
      }
      
    }
    
    return -1;     
  }
  public int handle_36(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_uni ) {  
        return 56;
      }
      
      if (true ) {  
        return 46;
      }
      
    }
    
    return -1;     
  }
  public int handle_37(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_uni ) {  
        return 10;
      }
      
      if (true ) {  
        return 36;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("wz", theAnswer);
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_uni ) {  
        return 30;
      }
      
      if (true ) {  
        return 15;
      }
      
    }
    
    return -1;     
  }
  public int handle_38(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_sc  && b_uni ) {  
        return 13;
      }
      
      if (true  && b_uni ) {  
        return 8;
      }
      
      if (true  && b_sc ) {  
        return 35;
      }
      
      if (true ) {  
        return 22;
      }
      
    }
    
    return -1;     
  }
  public int handle_39(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_40(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_cijfer  && b_wz ) {  
        return 50;
      }
      
      if (true  && b_cijfer ) {  
        return 3;
      }
      
      if (true  && b_wz ) {  
        return 61;
      }
      
      if (true ) {  
        return 11;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 25;
      }
      
      if (true ) {  
        return 32;
      }
      
    }
    
    return -1;     
  }
  public int handle_41(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_wz  && b_uni ) {  
        return 10;
      }
      
      if (true  && b_uni ) {  
        return 59;
      }
      
      if (true  && b_wz ) {  
        return 36;
      }
      
      if (true ) {  
        return 43;
      }
      
    }
    
    return -1;     
  }
  public int handle_42(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_cijfer  && b_uni ) {  
        return 30;
      }
      
      if (true  && b_cijfer ) {  
        return 15;
      }
      
      if (true  && b_uni ) {  
        return 19;
      }
      
      if (true ) {  
        return 7;
      }
      
    }
    
    return -1;     
  }
  public int handle_43(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_44(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 50;
      }
      
      if (true ) {  
        return 3;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("cijfer", theAnswer);
      
      
      if (true ) {  
        return 48;
      }
      
    }
    
    if (theQuestion == 2) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 25;
      }
      
    }
    
    return -1;     
  }
  public int handle_45(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_cijfer  && b_uni ) {  
        return 50;
      }
      
      if (true  && b_uni ) {  
        return 61;
      }
      
      if (true  && b_cijfer ) {  
        return 37;
      }
      
      if (true ) {  
        return 42;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("wz", theAnswer);
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_uni ) {  
        return 13;
      }
      
      if (true ) {  
        return 35;
      }
      
    }
    
    return -1;     
  }
  public int handle_46(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_47(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_cijfer  && b_wz  && b_uni ) {  
        return 50;
      }
      
      if (true  && b_cijfer  && b_wz ) {  
        return 37;
      }
      
      if (true  && b_wz  && b_uni ) {  
        return 61;
      }
      
      if (true  && b_cijfer  && b_uni ) {  
        return 3;
      }
      
      if (true  && b_uni ) {  
        return 11;
      }
      
      if (true  && b_wz ) {  
        return 42;
      }
      
      if (true  && b_cijfer ) {  
        return 28;
      }
      
      if (true ) {  
        return 33;
      }
      
    }
    
    return -1;     
  }
  public int handle_48(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 10;
      }
      
      if (true ) {  
        return 59;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 20;
      }
      
    }
    
    return -1;     
  }
  public int handle_49(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      
      if (true ) {  
        return 21;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("wz", theAnswer);
      
      
      if (true ) {  
        return 1;
      }
      
    }
    
    return -1;     
  }
  public int handle_50(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("cijfer", theAnswer);
      
      
      if (true ) {  
        return 10;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("wz", theAnswer);
      
      
      if (true ) {  
        return 30;
      }
      
    }
    
    if (theQuestion == 2) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 49;
      }
      
    }
    
    return -1;     
  }
  public int handle_51(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_cijfer  && b_wz ) {  
        return 49;
      }
      
      if (true  && b_cijfer ) {  
        return 4;
      }
      
      if (true  && b_wz ) {  
        return 60;
      }
      
      if (true ) {  
        return 12;
      }
      
    }
    
    return -1;     
  }
  public int handle_52(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_sc  && b_wz ) {  
        return 6;
      }
      
      if (true  && b_wz ) {  
        return 18;
      }
      
      if (true  && b_sc ) {  
        return 51;
      }
      
      if (true ) {  
        return 54;
      }
      
    }
    
    return -1;     
  }
  public int handle_53(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      
      if (true  && b_sc ) {  
        return 13;
      }
      
      if (true ) {  
        return 8;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      boolean b_sc = env.get("vo").equals("HBO");
      
      
      if (true  && b_sc ) {  
        return 6;
      }
      
      if (true ) {  
        return 18;
      }
      
    }
    
    return -1;     
  }
  public int handle_54(Map<String, String> env, int theQuestion, String theAnswer) {
    
    return -1;     
  }
  public int handle_55(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_wz  && b_uni ) {  
        return 50;
      }
      
      if (true  && b_wz ) {  
        return 37;
      }
      
      if (true  && b_uni ) {  
        return 3;
      }
      
      if (true ) {  
        return 28;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("cijfer", theAnswer);
      
      boolean b_uni = env.get("vo").equals("WO");
      
      
      if (true  && b_uni ) {  
        return 48;
      }
      
      if (true ) {  
        return 41;
      }
      
    }
    
    return -1;     
  }
  public int handle_56(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 2;
      }
      
    }
    
    return -1;     
  }
  public int handle_57(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 25;
      }
      
      if (true ) {  
        return 32;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("lt", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 6;
      }
      
      if (true ) {  
        return 51;
      }
      
    }
    
    return -1;     
  }
  public int handle_58(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("sc", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 50;
      }
      
      if (true ) {  
        return 61;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("wz", theAnswer);
      
      
      if (true ) {  
        return 13;
      }
      
    }
    
    if (theQuestion == 2) {
      env.put("uni", theAnswer);
      
      
      if (true ) {  
        return 6;
      }
      
    }
    
    return -1;     
  }
  public int handle_59(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("uni", theAnswer);
      
      boolean b_wz = (env.get("vo").equals("WO")) && (env.get("lt").equals("17"));
      
      
      if (true  && b_wz ) {  
        return 21;
      }
      
      if (true ) {  
        return 39;
      }
      
    }
    
    return -1;     
  }
  public int handle_60(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 1;
      }
      
      if (true ) {  
        return 9;
      }
      
    }
    
    return -1;     
  }
  public int handle_61(Map<String, String> env, int theQuestion, String theAnswer) {
    
    if (theQuestion == 0) {
      env.put("wz", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 30;
      }
      
      if (true ) {  
        return 19;
      }
      
    }
    
    if (theQuestion == 1) {
      env.put("uni", theAnswer);
      
      boolean b_cijfer = env.get("sc").equals("ja");
      
      
      if (true  && b_cijfer ) {  
        return 49;
      }
      
      if (true ) {  
        return 60;
      }
      
    }
    
    return -1;     
  }
  public void render_0(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is de universiteit?");
    
  }
  public void render_1(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
  }
  public void render_2(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_3(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_4(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
  }
  public void render_5(PrintWriter output, Map<String, String> env) {
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
  }
  public void render_6(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Weet je het zeker?");
    
  }
  public void render_7(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_8(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is de universiteit?");
    
  }
  public void render_9(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_10(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_11(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is de universiteit?");
    
  }
  public void render_12(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_13(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_14(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    
    output.println("0: Wat is je vooropleiding?");
    
  }
  public void render_15(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
  }
  public void render_16(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_17(PrintWriter output, Map<String, String> env) {
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Hoe oud ben je?");
    
  }
  public void render_18(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
  }
  public void render_19(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is de universiteit?");
    
  }
  public void render_20(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
  }
  public void render_21(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
  }
  public void render_22(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_23(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
  }
  public void render_24(PrintWriter output, Map<String, String> env) {
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is je vooropleiding?");
    
  }
  public void render_25(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is je cijfer?");
    
  }
  public void render_26(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_27(PrintWriter output, Map<String, String> env) {
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_28(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
  }
  public void render_29(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
  }
  public void render_30(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_31(PrintWriter output, Map<String, String> env) {
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Hoe oud ben je?");
    
    output.println("2: Wat is de universiteit?");
    
  }
  public void render_32(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
  }
  public void render_33(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_34(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_35(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
  }
  public void render_36(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
  }
  public void render_37(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
    output.println("1: Weet je het zeker?");
    
  }
  public void render_38(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
  }
  public void render_39(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_40(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_41(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
  }
  public void render_42(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
  }
  public void render_43(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_44(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is je cijfer?");
    
    output.println("2: Wat is de universiteit?");
    
  }
  public void render_45(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Weet je het zeker?");
    
  }
  public void render_46(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_47(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
  }
  public void render_48(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_49(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
    output.println("1: Weet je het zeker?");
    
  }
  public void render_50(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is je cijfer?");
    
    output.println("1: Weet je het zeker?");
    
    output.println("2: Wat is de universiteit?");
    
  }
  public void render_51(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
  }
  public void render_52(PrintWriter output, Map<String, String> env) {
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
  }
  public void render_53(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
    output.println("1: Wat is de universiteit?");
    
  }
  public void render_54(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
  }
  public void render_55(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Hoe oud ben je?");
    
    output.println("1: Wat is je cijfer?");
    
  }
  public void render_56(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Weet je het zeker? " + env.get("wz"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is de universiteit?");
    
  }
  public void render_57(PrintWriter output, Map<String, String> env) {
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Hoe oud ben je?");
    
  }
  public void render_58(PrintWriter output, Map<String, String> env) {
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Moet je schakelen?");
    
    output.println("1: Weet je het zeker?");
    
    output.println("2: Wat is de universiteit?");
    
  }
  public void render_59(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je cijfer? " + env.get("cijfer"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Wat is de universiteit?");
    
  }
  public void render_60(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is de universiteit? " + env.get("uni"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
  }
  public void render_61(PrintWriter output, Map<String, String> env) {
    
    output.println("Moet je schakelen? " + env.get("sc"));
    
    output.println("Hoe oud ben je? " + env.get("lt"));
    
    output.println("Wat is je vooropleiding? " + env.get("vo"));
    
    
    output.println("0: Weet je het zeker?");
    
    output.println("1: Wat is de universiteit?");
    
  }
}