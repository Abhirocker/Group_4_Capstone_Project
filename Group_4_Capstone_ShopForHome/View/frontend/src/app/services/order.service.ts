import {Injectable} from '@angular/core';
import {HttpClient} from "@angular/common/http";

import {Observable, of} from "rxjs";
import {Order} from "../models/Order";
import {apiUrl,discountUrl} from "../../environments/environment";
import {catchError, map,tap} from 'rxjs/operators';
import { Discount } from '../models/discount';


@Injectable({
    providedIn: 'root'
})
export class OrderService {

    private orderUrl = `${apiUrl}/order`;
    private discountUrl = `${discountUrl}`;
    

    constructor(private http: HttpClient) {
    }

    getPage(page = 1, size = 10): Observable<any> {
        return this.http.get(`${this.orderUrl}?page=${page}&size=${size}`).pipe();
    }

    show(id): Observable<Order> {
        return this.http.get<Order>(`${this.orderUrl}/${id}`).pipe(
            catchError(_ => of(null))
        );
    }

    cancel(id): Observable<Order> {
        return this.http.patch<Order>(`${this.orderUrl}/cancel/${id}`, null).pipe(
            catchError(_ => of(null))
        );
    }

    finish(id): Observable<Order> {
        return this.http.patch<Order>(`${this.orderUrl}/finish/${id}`, null).pipe(
            catchError(_ => of(null))
        );
    }

    
    getCouponPage(page = 1, size = 10): Observable<any> {
        return this.http.get(`${discountUrl}/coupon/list?page=${page}&size=${size}`).pipe();
    }

    getCoupon():Observable<any>{
        return this.http.get(`${apiUrl}/coupon/alllist`);
    }

    getCouponForUser(email:string):Observable<any>{
        return this.http.get(`${discountUrl}/coupon/alllist/${email}`);
    }

    addCoupon(code:string,emails:Array<string>): Observable<Discount> {
        console.log("service");
        console.log(emails);
        const url =`${apiUrl}/add/coupon/${code}` 
        return this.http.post<Discount>(url,emails);
    }

    deleteCoupon(code:number): Observable<any>{
        console.log("service")
        return this.http.post(`${apiUrl}/delete/coupon/${code}`,null);
    }
}
