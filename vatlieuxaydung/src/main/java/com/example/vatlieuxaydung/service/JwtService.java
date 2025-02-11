package com.example.vatlieuxaydung.service;

import com.example.vatlieuxaydung.exeption.AppException;
import com.example.vatlieuxaydung.exeption.ErrorCode;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import org.springframework.stereotype.Service;


import java.util.Date;

@Service
public class JwtService {
    private static final String SIGNER_KEY = "IJ3Ig6pBGeaw4eonbtyFbhmHbeLXkF54PPeyYRYwlVJnkKlJHAx3DsqfUWlLpC8S";

    public String validateAndExtractUsername(String authorizationHeader) {
        try {
            String token = null;
            if (authorizationHeader != null) {
                token = authorizationHeader.startsWith("Bearer ")?
                        authorizationHeader.substring(7): authorizationHeader;
            } else {
                throw new AppException(ErrorCode.UNAUTHORIZED);
            }
            JWSVerifier verifier = new MACVerifier(SIGNER_KEY.getBytes());
            SignedJWT signedJWT = SignedJWT.parse(token);
            Date expirationTime = signedJWT.getJWTClaimsSet().getExpirationTime();
            if (expirationTime.before(new Date())) {
                throw new AppException(ErrorCode.TOKEN_EXPIRED);
            }
            if(!signedJWT.verify(verifier)) throw new AppException(ErrorCode.INVALID_TOKEN);
            return signedJWT.getJWTClaimsSet().getSubject();

        } catch (Exception e) {
            throw new AppException(ErrorCode.INVALID_TOKEN);
        }
    }

    public String GenerateToken(String username) {
        JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);
        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(username)
                .issuer("vatlieuxaydung.com")
                .issueTime(new Date())
                .expirationTime(new Date(new Date().getTime() +3 * 24 * 60 * 60 * 1000))
                .build();
        Payload payload = new Payload(jwtClaimsSet.toJSONObject());
        JWSObject jwsObject = new JWSObject(header, payload);
        try {
            jwsObject.sign(new MACSigner(SIGNER_KEY.getBytes()));
            return jwsObject.serialize();
        } catch (JOSEException e) {
            throw new RuntimeException(e);
        }
    }


}
