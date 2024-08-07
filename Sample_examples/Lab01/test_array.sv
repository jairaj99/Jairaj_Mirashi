module test_array();

	// Declare a dynamic array data_da of int data type
	int data_da[];	
	// Declare queues data_q & addr_q of int data type
	int data_q[$], addr_q[$];


	// Declare associative array data_mem of int data type and indexed with bit[7:0]
	int data_mem[bit[7:0]];
	
	// Declare int variables result,idx
	int result,idx;
	

	initial
		begin
	
			// Allocate 10 memory locations for dynamic array & initialize
			// all the locations with some random values less than 20 & display the array
			data_da=new[10];
			foreach(data_da[i])
			data_da[i]={$random}%20;
		$display("da = %p",data_da);
				
			
			// Call the array reduction method sum which returns the sum
			// of all elements of array and collect the return value to the variable result
			
	result =data_da.sum;				
	$display("Sum of elements =%0d",result);          // Display the sum of elements, result
			
	
			// Similarly explore other array reduction methods 
			// product,or,and & xor
			result=data_da.product;
			$display("Product of elements =%0d",result);
	
			result = data_da.or;
			$display("OR operation of elements =%0d",result);

			result = data_da.xor;
			$display("XOR Operation of elements =%0d",result);

			// Call the array reduction method sum with "with" clause which returns 
			// total number of elements satisfying the condition within the "with" clause 

			result = data_da.sum with (int'(item>7));
			// Display the value of the result
			
			$display(" no. of items greater than 7 = %0d", result);
			
			// Similarly explore other array reduction methods with "with"clause 
		
			result = data_da.sum with ((item>7)*item);
			
			$display(" Sum of the items which are greater than 7 = %0d", result);
	
			// Sorting Methods
	
			// call all the sorting methods like reverse, sort, rsort & 
			// shuffle & display the array after execution of each method to 
			// understand the behaviour of the array methods
	
	data_da.sort();
	$display("After Soriting da = %p", data_da);

	data_da.rsort();
	$display("Afterc RSoriting da = %p", data_da);
	data_da.reverse();
	$display("After Reverse da = %p", data_da);
	data_da.shuffle();
	$display("After Shuffling da = %p", data_da);
			// Call Array locator methods like min, max, unique,find_* with,
			// find_*_index with using dynamic array & display 
			// the contents of data_q after execution of each method to 
			// understand the behaviour of the array methods
			
		data_q=data_da.min();
		$display("After calling MIN data_q = %p", data_q);
		
		data_q=data_da.max();
		$display("After calling MAX data_q = %p", data_q);
	
		data_q=data_da.unique();
		$display("Aftercalling Unique data_q = %p", data_q);
			
		data_q=data_da.find_first with(item > 4);
		$display("After calling FIND FIRST with item > 4 data_q = %p", data_q);
		

		data_q=data_da.find_last with(item > 4);
		$display("After calling FIND LAST with item > 4 data_q = %p", data_q);

		data_q=data_da.find_first_index with(item > 4);
		$display("After calling FIND FIRST INDEX with item > 4 data_q = %p", data_q);

		
		data_q=data_da.find_last_index with(item > 4) ;
		$display("After calling FIND LAST INDEX with item > 4 data_q = %p", data_q);

	//Generate some 10 random address less than 100 within a repeat loop 
			//push the address in to the addr_q
			
		repeat(10)
		begin
		result={$random}%100;
		addr_q.push_back(result);
		end			
			//Display the addr_q
		$display("Random address in addr_q= %p", addr_q);	
			
			
			
			// With in for loop update the associate array with random data less than 200
			// based on the address stored in addr_q
			// Hint: To get the address use pop method 
			for(int i=0;i<10;i++)
			begin
			data_mem[addr_q.pop_front] = {$random}%200;
			end

			// Display the contents of associate array using foreach loop
			
			foreach(data_mem[i])
			$display("data_mem [%0d] = [%0d]",i,data_mem[i]);
			if(data_mem.first(idx))
			// Display the first index of the array by using associative array method first
			
			$display(" Index of the first element is %0d ", idx);

			// Display the first element of the array
			$display(" first element is %0d ", data_mem[idx]);
			// Display the last index of the array by using associative array method last
			
			if(data_mem.last(idx))	
			$display(" Index of the last element is %0d ", idx);

			// Display the last element of the array
				$display(" Last element is %0d ", data_mem[idx]);
		end
	
endmodule
	
