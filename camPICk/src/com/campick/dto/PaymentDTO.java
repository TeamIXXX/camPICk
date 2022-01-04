/*======================================
	paymentDTO.java
	결제 자료형 클래스(DTO)
=======================================*/

package com.campick.dto;

public class PaymentDTO
{
	private String paymentNum, bookingNum, comfirmNum, paymentDate;
	private int paymentAmount;
	
	// getter / setter 구성
	public String getPaymentNum()
	{
		return paymentNum;
	}
	public void setPaymentNum(String paymentNum)
	{
		this.paymentNum = paymentNum;
	}
	public String getBookingNum()
	{
		return bookingNum;
	}
	public void setBookingNum(String bookingNum)
	{
		this.bookingNum = bookingNum;
	}
	public String getComfirmNum()
	{
		return comfirmNum;
	}
	public void setComfirmNum(String comfirmNum)
	{
		this.comfirmNum = comfirmNum;
	}
	public String getPaymentDate()
	{
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate)
	{
		this.paymentDate = paymentDate;
	}
	public int getPaymentAmount()
	{
		return paymentAmount;
	}
	public void setPaymentAmount(int paymentAmount)
	{
		this.paymentAmount = paymentAmount;
	}
}
