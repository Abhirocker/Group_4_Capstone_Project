import { Component, OnDestroy, OnInit } from '@angular/core';
import { OrderService } from 'src/app/services/order.service';
import { UserService } from 'src/app/services/user.service';

import {Subscription} from "rxjs";
import { Discount } from 'src/app/models/discount';
import {ActivatedRoute, Router} from '@angular/router';


@Component({
  selector: 'app-discount',
  templateUrl: './discount.component.html',
  styleUrls: ['./discount.component.css']
})
export class DiscountComponent implements OnInit,OnDestroy {

  constructor(private route:ActivatedRoute,
    private orderService : OrderService,
    private router: Router,
    private userService: UserService) { }

    page: any; 
    querySub: Subscription;
    discountDetail : Discount;
    coupon : any;
    selectedUser :string[];
    users : any;            
    userList : [];
    


  ngOnInit() {
    this.querySub = this.route.queryParams.subscribe(() => {
      this.getCouponList();
    //this.userService.getPage().subscribe(response => this.page= response);
    console.log(this.page);
  });
  this.userService.getAllUsers().subscribe(prods => {
    this.users = prods;
  });
  this.selectedUser=new Array<string>();
  }

            


  getCouponList(){
    let nextPage=1;
    let size = 10;
    if(this.route.snapshot.queryParamMap.get('page')){
      nextPage =+ this.route.snapshot.queryParamMap.get('page');
      size =+ this.route.snapshot.queryParamMap.get('size');
    }
    this.orderService.getCouponPage(nextPage,size).subscribe(page => this.page = page, _ =>{
      console.log("Get User Failed")
    });

  }


  addCoupon(code:string){
    console.log("addCoupon")
    this.orderService.addCoupon(code,this.selectedUser).subscribe(response => this.getCouponList());
    //this.getCouponList();
  }

  deleteCoupon(code:number){
    this.orderService.deleteCoupon(code).subscribe(response => this.getCouponList());
  }

  checked(item: string){
    if(this.selectedUser.indexOf(item) != -1){
      return true;
    }
  }

  onChange(checked,item:string){
    if(checked){
      this.selectedUser.push(item);
    }else{
      this.selectedUser.slice(this.selectedUser.indexOf(item),1)
    }
  }

  getEmail(e:any,email:string){
    if(e.target.checked){
      console.log(email + 'checked');
      this.selectedUser.push(email);
    }
    else{
      console.log(email + 'Unchecked');
      this.selectedUser=this.selectedUser.filter(m=>m!=email);
    }
  }

  ngOnDestroy(): void {
  }


}
