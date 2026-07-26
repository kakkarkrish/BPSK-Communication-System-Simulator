bits=randi([0 1],1,100000);
bpsk=2*bits-1;
noise_levels=[0 0.5 1 2];
%% noise vs ber
ber_values = zeros(size(noise_levels));
for i=1:length(noise_levels)
    noise=noise_levels(i)*randn(size(bpsk));
    received = bpsk + noise;
    received_bits=received>0;
    bit_errors = sum(bits ~= received_bits);
    ber_values(i) = bit_errors / length(bits);
     fprintf("Noise = %.1f, BER = %.5f\n",noise_levels(i),ber_values(i));
end
disp(ber_values)
%% snr vs ber
bits=randi([0 1],1,100000);
bpsk=2*bits-1;
snr_db=0:2:10;
for i=1:length(snr_db)
    snr=10^(snr_db(i)/10);
    noise_power=1/snr;
    noise_amplitude=sqrt(noise_power);
    noise = noise_amplitude * randn(size(bpsk));
    received = bpsk + noise;
    received_bits = received > 0;
    bit_errors = sum(bits ~= received_bits);
    ber_values(i) = bit_errors / length(bits);
    fprintf("SNR = %.1f dB, BER = %.5f\n", snr_db(i), ber_values(i));
end
disp(ber_values)
%% 
figure;
semilogy(snr_db, ber_values,'-o','LineWidth',2);
grid on;

xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER vs SNR for BPSK');